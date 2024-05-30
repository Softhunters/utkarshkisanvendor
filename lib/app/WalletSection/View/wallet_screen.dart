// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// import '../../../common_widgets/app_colors.dart';
// import '../../../constant/cons.dart';
// import '../../../widgets/app_button_widget.dart';
// import '../Controller/wallet_controller.dart';
//
// class WalletsScreen extends StatelessWidget {
//   const WalletsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = ScreenUtils.getScreenSize(context);
//     final orientation = MediaQuery.orientationOf(context);
//     final layoutInfo = (screenSize, orientation);
//     var isBigDevice = ScreenUtils.isBigDevice(screenSize);
//     if (isBigDevice) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//       });
//     }
//     double width = MediaQuery.sizeOf(context).width;
//     double height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding:
//           switch (layoutInfo){
//           (_,Orientation.landscape)=> const EdgeInsets.symmetric(horizontal: 25.0),_=> const EdgeInsets.symmetric(horizontal: 12.0),
//           },
//           child: ListView(
//             children: <Widget>[
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Card(
//                     color: AppColors.primaryBlack,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius: BorderRadius.circular(10)),
//                       width: width * .5,
//                       height: 80,
//                       child: Center(
//                         child: Column(
//                           children: [
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Available Balance",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge
//                                   ?.copyWith(color: AppColors.white),
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             Text(
//                               "₹ 300",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleLarge
//                                   ?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.white),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 height: switch (layoutInfo) {
//                   (_, Orientation.landscape) => height*.6,
//                   _ => height*.28
//                 },
//                 child: const CardWidget(),
//               ),
//               Container(
//                   height: switch (layoutInfo) {
//                     (_, Orientation.landscape) => 490,
//                     _ => 325
//                   },
//                   child: ExpensesWidget())
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CardWidget extends StatefulWidget {
//   const CardWidget({super.key});
//
//   @override
//   _CardWidgetState createState() => _CardWidgetState();
// }
//
// class _CardWidgetState extends State<CardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = ScreenUtils.getScreenSize(context);
//     final orientation = MediaQuery.orientationOf(context);
//     final layoutInfo = (screenSize, orientation);
//     var isBigDevice = ScreenUtils.isBigDevice(screenSize);
//     if (isBigDevice) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//       });
//     }
//     WalletController read = context.read<WalletController>();
//     WalletController watch = context.watch<WalletController>();
//     var height = MediaQuery.sizeOf(context).height;
//     var width = MediaQuery.sizeOf(context).width;
//     double fontSize(double size) {
//       return size * width / 414;
//     }
//
//     return Column(
//       children: <Widget>[
//         Container(
//             // margin: EdgeInsets.symmetric(horizontal: width / 20),
//             alignment: Alignment.centerLeft,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Card Selected",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: switch (layoutInfo){
//                         (_,Orientation.landscape) =>  18, _=>18},
//                       color: AppColors.primaryColor),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     showModelSheet(watch, read);
//                   },
//                   child: Text(
//                     "+Add Card",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: switch (layoutInfo){
//                           (_,Orientation.landscape) =>  18, _=>18},
//                         color: AppColors.primaryColor),
//                   ),
//                 ),
//               ],
//             )),
//         SizedBox(height: 10,),
//         Container(
//           height: height*.22,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 3,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 18.0),
//                     child: Container(
//                       width: switch (layoutInfo) {
//                         (_, Orientation.landscape) => width * .45,
//                         _ => width*.85
//                       },
//                      height: 120,
//                       decoration: BoxDecoration(
//                         boxShadow: AppColors.neumorpShadow,
//                         color: AppColors.primaryBlack,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       // margin: EdgeInsets.symmetric(
//                       //     horizontal: width / 25, vertical: height / 20),
//                       child: Stack(
//                         children: <Widget>[
//                           Positioned.fill(
//                             top: height*.17,
//                             bottom: -200,
//                             left: 0,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.blue[700]!.withOpacity(0.4),
//                                         blurRadius: 50,
//                                         spreadRadius: 2,
//                                         offset: const Offset(20, 0)),
//                                     const BoxShadow(
//                                         color: Colors.white12,
//                                         blurRadius: 0,
//                                         spreadRadius: -2,
//                                         offset: Offset(0, 0)),
//                                   ],
//                                   color: Colors.white30),
//                             ),
//                           ),
//                           Positioned.fill(
//                             top: -100,
//                             bottom: -100,
//                             left: -550,
//                             child: Container(
//                               width: 100,
//                               decoration: BoxDecoration(boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.blue[900]!.withOpacity(0.2),
//                                     blurRadius: 50,
//                                     spreadRadius: 2,
//                                     offset: const Offset(20, 0)),
//                                 const BoxShadow(
//                                     color: Colors.white12,
//                                     blurRadius: 0,
//                                     spreadRadius: -2,
//                                     offset: Offset(0, 0)),
//                               ], shape: BoxShape.circle, color: Colors.white30),
//                             ),
//                           ),
//                           BankCard(),
//                         ],
//                       ),
//                     ),
//                   );
//                 })),
//       ],
//     );
//   }
//
//   void showModelSheet(watch, read) {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (builder) {
//           return StatefulBuilder(
//             builder: (context, setState) => Container(
//               // height: 500.0,
//               color: Colors.transparent,
//               //could change this to Color(0xFF737373),
//               //so you don't have to change MaterialApp canvasColor
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30.0),
//                             topRight: Radius.circular(30.0))),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         CreditCardWidget(
//                           enableFloatingCard: true,
//                           cardNumber: watch.cardNumber,
//                           expiryDate: watch.expiryDate,
//                           cardHolderName: watch.cardHolderName,
//                           cvvCode: watch.cvvCode,
//                           showBackView: watch.isCvvFocused,
//                           obscureCardNumber: false,
//                           obscureCardCvv: true,
//                           isHolderNameVisible: true,
//                           cardBgColor: AppColors.primaryBlack,
//                           isSwipeGestureEnabled: true,
//                           onCreditCardWidgetChange:
//                               (CreditCardBrand creditCardBrand) {},
//                           customCardTypeIcons: [
//                             CustomCardTypeIcon(
//                               cardType: CardType.mastercard,
//                               cardImage: Image.asset(
//                                 'assets/images/mastercard.png',
//                                 height: 48,
//                                 width: 48,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         CreditCardForm(
//                           formKey: watch.formKey,
//                           // Required
//                           cardNumber: read.cardNumber,
//                           // Required
//                           expiryDate: watch.expiryDate,
//                           // Required
//                           cardHolderName: watch.cardHolderName,
//                           // Required
//                           cvvCode: watch.cvvCode,
//                           onCreditCardModelChange:
//                               (CreditCardModel creditCardModel) {
//                             setState(() {
//                               watch.cardNumber = creditCardModel.cardNumber;
//                               watch.expiryDate = creditCardModel.expiryDate;
//                               watch.cardHolderName =
//                                   creditCardModel.cardHolderName;
//                               watch.cvvCode = creditCardModel.cvvCode;
//                               watch.isCvvFocused = creditCardModel.isCvvFocused;
//                             });
//                           },
//                           // Required
//                           obscureCvv: true,
//                           obscureNumber: false,
//                           isHolderNameVisible: true,
//                           isCardNumberVisible: true,
//                           isExpiryDateVisible: true,
//                           enableCvv: true,
//                           cvvValidationMessage: 'Please input a valid CVV',
//                           dateValidationMessage: 'Please input a valid date',
//                           numberValidationMessage:
//                               'Please input a valid number',
//                           cardNumberValidator: (String? cardNumber) {},
//                           expiryDateValidator: (String? expiryDate) {},
//                           cvvValidator: (String? cvv) {},
//                           cardHolderValidator: (String? cardHolderName) {},
//                           onFormComplete: () {
//                             // callback to execute at the end of filling card data
//                           },
//                           autovalidateMode: AutovalidateMode.always,
//                           disableCardNumberAutoFillHints: false,
//                           inputConfiguration: const InputConfiguration(
//                             cardNumberDecoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               labelText: 'Number',
//                               hintText: 'XXXX XXXX XXXX XXXX',
//                             ),
//                             expiryDateDecoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               labelText: 'Expired Date',
//                               hintText: 'XX/XX',
//                             ),
//                             cvvCodeDecoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               labelText: 'CVV',
//                               hintText: 'XXX',
//                             ),
//                             cardHolderDecoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.primaryColor)),
//                               labelText: 'Card Holder',
//                             ),
//                             cardNumberTextStyle: TextStyle(
//                               fontSize: 10,
//                               color: Colors.black,
//                             ),
//                             cardHolderTextStyle: TextStyle(
//                               fontSize: 10,
//                               color: Colors.black,
//                             ),
//                             expiryDateTextStyle: TextStyle(
//                               fontSize: 10,
//                               color: Colors.black,
//                             ),
//                             cvvCodeTextStyle: TextStyle(
//                               fontSize: 10,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: AppButton(
//                                   height: 40,
//                                   bgColor: AppColors.white,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16,
//                                       color: AppColors.primaryColor),
//                                   width: 200,
//                                   title: "Cancel",
//                                   onTap: () {
//                                     read.cardNumber = "";
//                                     read.expiryDate = "";
//                                     read.cardHolderName = "";
//                                     read.cvvCode = "";
//                                     Get.back();
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 20,
//                               ),
//                               Expanded(
//                                 child: AppButton(
//                                   height: 40,
//                                   width: 200,
//                                   title: "Add",
//                                   onTap: () {},
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                       ],
//                     )),
//               ),
//             ),
//           );
//         });
//   }
// }
//
// class BankCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = ScreenUtils.getScreenSize(context);
//     final orientation = MediaQuery.orientationOf(context);
//     final layoutInfo = (screenSize, orientation);
//     var isBigDevice = ScreenUtils.isBigDevice(screenSize);
//     if (isBigDevice) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//       });
//     }
//     var height = MediaQuery.sizeOf(context).height;
//     var width = MediaQuery.sizeOf(context).width;
//     double fontSize(double size) {
//       return size * width / 414;
//     }
//
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       padding:
//           EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 25),
//       child: Stack(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//                 alignment: Alignment.topLeft,
//                 width: switch (layoutInfo) {
//                   (_, Orientation.landscape) => width / 5,
//                   _ => width / 2.5,
//                 },
//                 child: Image.asset(
//                   "assets/images/mastercardlogo.png",
//                   fit: BoxFit.fill,
//                 )),
//           ),
//           Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                 height: height * .3,
//                 width: switch (layoutInfo) {
//                   (_, Orientation.landscape) => width / 4,
//                   _ => width / 1.9,
//                 },
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     const Row(
//                       children: <Widget>[
//                         Text(
//                           "**** **** **** ",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           "1930",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                     Text(
//                       "Platinum Card".toUpperCase(),
//                       style: const TextStyle(
//                           fontSize: 15, fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               )),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Container(
//               alignment: Alignment.bottomRight,
//               width: switch (layoutInfo) {
//                 (_, Orientation.landscape) => width / 12,
//                 _ => width / 6,
//               },
//               height: switch (layoutInfo) {
//                 (_, Orientation.landscape) => height / 8,
//                 _ => height / 16,
//               },
//               decoration: BoxDecoration(
//                   color: AppColors.primaryBlack,
//                   boxShadow: AppColors.neumorpShadow,
//                   borderRadius: BorderRadius.circular(20)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ExpensesWidget extends StatefulWidget {
//   @override
//   _ExpensesWidgetState createState() => _ExpensesWidgetState();
// }
//
// class _ExpensesWidgetState extends State<ExpensesWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = ScreenUtils.getScreenSize(context);
//     final orientation = MediaQuery.orientationOf(context);
//     final layoutInfo = (screenSize, orientation);
//     var isBigDevice = ScreenUtils.isBigDevice(screenSize);
//     if (isBigDevice) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//       });
//     }
//     var height = MediaQuery.sizeOf(context).height;
//     var width = MediaQuery.sizeOf(context).width;
//     double fontSize(double size) {
//       return size * width / 414;
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           height: switch (layoutInfo) {
//             (_, Orientation.landscape) => height / 6,
//             _ => height / 14,
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                   margin: EdgeInsets.only(left: width / 40),
//                   child: Text(
//                     "Monthly Expenses",
//                     style: TextStyle(
//                         color: Colors.amber,
//                         fontWeight: FontWeight.bold,
//                         fontSize: switch (layoutInfo){
//                           (_,Orientation.landscape) =>  18, _=>18},),
//                   )),
//               Container(
//                 width: width / 3.5,
//                 margin: EdgeInsets.only(right: width / 40),
//                 child: Row(
//                   children: <Widget>[
//                     ArrowButton(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 10),
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         size:  switch (layoutInfo){
//                           (_,Orientation.landscape) =>  25, _=>18},
//                         color: AppColors.white,
//                       ),
//                     ),
//                     Padding(padding: EdgeInsets.only(left: width / 50)),
//                     ArrowButton(
//                       icon: Icon(
//                         Icons.arrow_forward_ios,
//                         size:  switch (layoutInfo){
//                           (_,Orientation.landscape) =>  25, _=>18},
//                         color: AppColors.white,
//                       ),
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 10),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         const SizedBox(height: 10,),
//         Expanded(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Expanded(
//                 flex: 5,
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: category.map((data) {
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 5),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Container(
//                               margin: const EdgeInsets.only(right: 10),
//                               width: 8,
//                               height: 8,
//                               decoration: BoxDecoration(
//                                   color: AppColors
//                                       .pieColors[category.indexOf(data)],
//                                   shape: BoxShape.circle),
//                             ),
//                             Text(
//                               data['name'],
//                               style: TextStyle(
//                                   fontSize:switch (layoutInfo){
//                                     (_,Orientation.landscape) =>  16, _=>14},
//                                   color: AppColors.primaryColor),
//                             )
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//               const Expanded(
//                 flex: 5,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 10),
//                   child: PieChart(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// List category = [
//   {"name": "Groceries", "amount": 500.0},
//   {"name": "Online Shopping", "amount": 1000.0},
//   {"name": "Eating Out", "amount": 80.0},
//   {"name": "Bills", "amount": 500.0},
//   {"name": "Subscriptions", "amount": 100.0},
//   {"name": "Fees", "amount": 300.0},
// ];
//
// class PieChart extends StatefulWidget {
//   const PieChart({super.key});
//
//   @override
//   _PieChartState createState() => _PieChartState();
// }
//
// class _PieChartState extends State<PieChart>
//     with SingleTickerProviderStateMixin {
//   double total = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     category.forEach((e) => total += e['amount']);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = ScreenUtils.getScreenSize(context);
//     final orientation = MediaQuery.orientationOf(context);
//     final layoutInfo = (screenSize, orientation);
//     var width = MediaQuery.sizeOf(context).width;
//     double fontSize(double size) {
//       return size * width / 414;
//     }
//
//     return LayoutBuilder(
//       builder: (context, constraint) {
//         return Container(
//           height:switch (layoutInfo){
//             (_,Orientation.landscape) =>  200, _=> 200},
//           decoration: BoxDecoration(
//               color: AppColors.primaryBlack,
//               shape: BoxShape.circle,
//               boxShadow: AppColors.neumorpShadow),
//           child: Stack(
//             children: <Widget>[
//               Center(
//                 child: SizedBox(
//                   width: constraint.maxWidth *
//                       switch (layoutInfo) {
//                         (_, Orientation.landscape) => 0.25,
//                         _ => .6
//                       },
//                   child: CustomPaint(
//                     foregroundPainter: PieChartCustomPainter(
//                       width: constraint.maxWidth *
//                           switch (layoutInfo) {
//                             (_, Orientation.landscape) => 0.25,
//                             _ => .5
//                           },
//                       categories: category,
//                     ),
//                     child: Container(),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Container(
//                   width: constraint.maxWidth * switch (layoutInfo){
//                     (_,Orientation.landscape) =>  0.25, _=>.5},
//                   decoration: const BoxDecoration(
//                       color: AppColors.primaryBlack,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                             spreadRadius: 3,
//                             blurRadius: 5,
//                             offset: Offset(3, 3),
//                             color: Colors.black38)
//                       ]),
//                   child: Center(
//                       child: Text(
//                     "\$" + total.toString(),
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: switch (layoutInfo){
//                       (_,Orientation.landscape) =>  14, _=>12}),
//                   )),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class PieChartCustomPainter extends CustomPainter {
//   final List categories;
//   final double width;
//
//   PieChartCustomPainter({required this.categories, required this.width});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Offset center = Offset(size.width / 2, size.height / 2);
//     double radius = min(size.width / 2, size.height / 2);
//     double total = 0;
//     double startRadian = -pi / 2;
//     var paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = width / 1.5;
//     categories.forEach((f) => total += f['amount']);
//     for (var i = 0; i < categories.length; i++) {
//       final currentCategory = categories[i];
//       final sweepRadian = (currentCategory['amount'] / total) * 2 * pi;
//       paint.color = AppColors.pieColors[i];
//       canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
//           startRadian, sweepRadian, false, paint);
//       startRadian += sweepRadian;
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
//
// class ArrowButton extends StatelessWidget {
//   final EdgeInsets margin;
//   final Widget icon;
//
//   ArrowButton({required this.margin, required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.sizeOf(context).height;
//     var width = MediaQuery.sizeOf(context).width;
//     return Expanded(
//       child: Container(
//         margin: margin,
//         decoration: BoxDecoration(
//             color: AppColors.primaryBlack,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: AppColors.neumorpShadow),
//         alignment: Alignment.center,
//         child: icon,
//       ),
//     );
//   }
// }
