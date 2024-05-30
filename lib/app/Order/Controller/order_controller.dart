import 'dart:io';

import 'package:e_commerce/app/Order/Controller/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common_widgets/snack_bar.dart';
import '../View/order_detail_screen.dart';
import '../model/order_deatil_model.dart';

class OrderController extends ChangeNotifier {
  OrderApi orderApi = OrderApi();

  TextEditingController reviewController = TextEditingController();
  int segmentedControlGroupValue = 0;
  List itemData = [];
  List<Order> order = [];
  double tutorRating = 0.0;

  bool isLoading = false;

  getOrders() async {
    isLoading = true;
    var result = await orderApi.getAllOrder();
    if (result != null) {
      order = result.result?.order ?? [];
      isLoading = false;
      notifyListeners();
    }
  }

  bool orderLoading = false;
  Order? orderDetail;
  List<Orderitem> orderedItem = [];

  int activeStep = 0;

  getOrdersDetail(String orderId) async {
    orderLoading = true;
    var result = await orderApi.getAllOrderDetail(orderId);
    if (result != null) {
      orderDetail = result.result?.order;
      orderedItem = result.result?.orderitem ?? [];
      if (orderDetail?.status == "ordered") {
        activeStep = 1;
      } else if (orderDetail?.status == "accepted" ||
          orderDetail?.status == "rejected") {
        activeStep = 2;
      } else if (orderDetail?.status == "delivered") {
        activeStep = 4;
      }

      orderLoading = false;
      notifyListeners();
    }
  }

  creadteReview(ReviewCreate data, ValueSetter<bool> onResponse) async {
    var result = await orderApi.createReviewApi(data);
    if (result != null) {
      showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: result["message"]);
      onResponse(true);
      filePaths.clear();
      tutorRating = 0.0;
      reviewController.clear();
      imageFileList!.clear();
      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }
  }

  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];
  List<String> filePaths = [];

  selectImages() async {
    List<XFile> xFiles = await imagePicker.pickMultiImage();
    if (xFiles != null) {
      // Clear existing imageFileList before adding new ones
      imageFileList?.clear();
      for (XFile xFile in xFiles) {
        // Convert each XFile to a File and add it to the list
        File file = File(xFile.path);
        imageFileList?.add(file);
        // Also add the file path to the filePaths list
        filePaths.add(xFile.path);
      }
    }

    notifyListeners();
  }

  cancelOrder(String orderId, String itemId) async {
    print("cancel Order start");
    final result = await orderApi.cancelOrderApi(orderId, itemId);
    if(result !=null){
      getOrders();
      getOrdersDetail(orderId);
      notifyListeners();
    }
  }

  returnOrder(String orderId, String itemId) async {
    // print("cancel Order start");
    final result = await orderApi.returnOrderApi(orderId, itemId);
    if(result !=null){
      getOrders();
      getOrdersDetail(orderId);
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> step = [
    {
      "activeStep": 0,
      "step": "Waiting",
    },
    {"activeStep": 1, "step": "Order Received"},
    {
      "activeStep": 2,
      "step": "Preparing",
    },
    {
      "activeStep": 3,
      "step": "On Way",
    },
    {
      "activeStep": 4,
      "step": "Delivered",
    },
  ];
  List<Map<String, dynamic>> stepReject = [
    {
      "activeStep": 0,
      "step": "Waiting",
    },
    {"activeStep": 1, "step": "Order Rejected"},
  ];
  List<Map<String, dynamic>> stepCancel = [
    {
      "activeStep": 0,
      "step": "Waiting",
    },
    {"activeStep": 1, "step": "Order Received"},
    {
      "activeStep": 2,
      "step": "Preparing",
    },
    {
      "activeStep": 3,
      "step": "Canceled",
    },
  ];

// double tutorRating = 0.0;
}
