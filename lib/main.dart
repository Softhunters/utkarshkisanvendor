import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:e_commerce/app/onBoard/on_boarding_screen.dart';
import 'package:e_commerce/common_widgets/app_strings.dart';
import 'package:e_commerce/config/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'app/Auth/view_model/auth_controller.dart';
import 'app/Brand/controller/brand_controller.dart';
import 'app/CartSection/Controller/cart_controller.dart';
import 'app/Home/controller/home_controller.dart';
import 'app/Order/Controller/order_controller.dart';
import 'app/Profile/Controller/profile_controller.dart';
import 'app/Search/controller/search_controller.dart';
import 'app/Wallet/Controller/wallets_controller.dart';
import 'app/WalletSection/Controller/wallet_controller.dart';
import 'app/no_internet/connectivity_checker.dart';
import 'config/shared_prif.dart';



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)..badCertificateCallback
    = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  await SharedStorage.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthController>(create: (context) {
        return AuthController();
      },
    ),
    ChangeNotifierProvider<HomeController>(
        create: (context) => HomeController()),
    ChangeNotifierProvider<SearchScreenController>(
        create: (context) => SearchScreenController()),
    ChangeNotifierProvider<CartController>(
        create: (context) => CartController()),
    ChangeNotifierProvider<ProfileController>(
        create: (context) => ProfileController()),
    ChangeNotifierProvider<OrderController>(
        create: (context) => OrderController()),
    ChangeNotifierProvider<WalletsController>(
        create: (context) => WalletsController()),
    ChangeNotifierProvider<BrandController>(
        create: (context) => BrandController()),
    ChangeNotifierProvider<CurrencyProvider>(
        create: (context) => CurrencyProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings();

  bool isLogin = false;

  @override
  void initState() {
    firebaseNotification();
    isLogin = SharedStorage.localStorage?.getBool(AppStrings.isLogin) ?? false;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initNoInternetListener(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: AppTheme.light,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.dark,
      home: OnBoardScreen(),
      // routes: {
      //   "/bottom_navi": (context) => const BottomBarScreen(),
      //
      // },
    );
  }

  firebaseNotification() async {
    firebaseMessaging.requestPermission(alert: true);
    firebaseMessaging.isAutoInitEnabled;
    var android =
        const AndroidInitializationSettings('@drawable/ic_launcher.png');

    var ios = const DarwinInitializationSettings();
    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseMessaging.requestPermission(
        sound: true, alert: true, badge: true, provisional: true);
    initLocalNotification();

    // getFcmToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      var data = message.data;

      AndroidNotification? android = message.notification?.android;
      AppleNotification? appleNotification = message.notification?.apple;

      if (notification != null && android != null) {
        showNotification(message.notification, jsonEncode((data)));

        FirebaseMessaging.instance.getInitialMessage().then((message) {
          if (message != null) {
          } else {}
        });
      } else if (notification != null && appleNotification != null) {
        showNotification(message.notification, jsonEncode((data)));
      } else {}
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {}
    });

    firebaseMessaging.getToken().then((String? token) async {
      if (token == null) {
      } else {}
    }).catchError((error) {
      print(error.toString());
    });
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      print('FlutterFire Messaging Example: Getting APNs token...');
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('FlutterFire Messaging Example: Got APNs token: $token');
    }
  }

  Future showNotification(RemoteNotification? notification, data) async {
    var android = const AndroidNotificationDetails(
      'CHANNLEID',
      "CHANNLENAME",
      channelDescription: "channelDescription",
      importance: Importance.max,
      fullScreenIntent: true,
      priority: Priority.high,
      icon: "@mipmap/ic_launcher",
      visibility: NotificationVisibility.public,
    );

    var iOS = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(DateTime.now().second,
        notification?.title, notification?.body, platform,
        payload: data);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message==$message");
  }

  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print("receive==$payload,== $body");
    // Get.offAll(NotificationScreen());
  }

  // Future _selectNotification(payload) async {
  //   print("payload android==$payload");
  //   // var data = payload;
  //   if (payload != null) {
  //     /// ALL Routes
  //   }
  // }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      var data = jsonDecode(payload!);

      if (data["type"] == "job") {}
    }
    // Get.offAll(NotificationScreen());
  }

  Future initLocalNotification() async {
    if (Platform.isIOS) {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );

      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    } else {
      var initializationSettingsAndroid = const AndroidInitializationSettings(
          'ic_launcher'); // Icon name updated here
      var initializationSettingsIOS = DarwinInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
      );
    }
  }
}


