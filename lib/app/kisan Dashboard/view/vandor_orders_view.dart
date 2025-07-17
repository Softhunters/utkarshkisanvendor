import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../constant/cons.dart';
import 'order_list_view.dart';

class VandorOrdersView extends StatefulWidget {
  const VandorOrdersView({super.key});

  @override
  State<VandorOrdersView> createState() => _VandorOrdersViewState();
}

class _VandorOrdersViewState extends State<VandorOrdersView> {
  bool _shouldPop = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenSize = ScreenUtils.getScreenSize(context);
    if (ScreenUtils.isBigDevice(screenSize) && !_shouldPop) {
      _shouldPop = true; // prevent repeating
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<DashboardController>(
      builder: (context, controller, _) {
        final vendorOrders = controller.vendorOrders;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Your Orders"),
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: vendorOrders == null || vendorOrders.isEmpty
                ? const Center(child: Text("No orders available"))
                : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vendorOrders.length,
                    itemBuilder: (context, index) {
                      var datas = vendorOrders[index];
                      return GestureDetector(
                        onTap: () async{
                          await controller.getOrderListData(datas.orderId??'');
                          Get.to(() => const OrderListView());
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(

                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInfoColumn(
                                      title: "Order No.",
                                      value: datas.orderNumber ?? '',
                                    ),
                                    _buildInfoColumn(
                                      title: "Order On",
                                      value: datas.createdAt?.split("T").first ?? '',
                                        aligment: CrossAxisAlignment.end
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInfoColumn(
                                      title: "Status",
                                      value: datas.status ?? '',
                                      valueColor: _getStatusColor(datas.status),
                                    ),
                                    _buildInfoColumn(
                                      title: "Price",
                                      value: "₹${datas.totalPrice ?? '0'}",
                                      aligment: CrossAxisAlignment.end
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInfoColumn(
                                      title: "No of items",
                                      value: datas.totalProducts ?? '',
                                      aligment: CrossAxisAlignment.center

                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoColumn({
    required String title,
    required String value,
    Color? valueColor,
    CrossAxisAlignment? aligment
  }) {
    return Column(
      crossAxisAlignment: aligment??CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w300,
            color: AppColors.grey1,
          ),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w300,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }


  Color _getStatusColor(String? status) {
    switch (status) {
      case "ordered":
        return AppColors.indigo;
      case "delivered":
        return AppColors.green;
      case "accepted":
        return AppColors.orange;
      default:
        return AppColors.redColor;
    }
  }
}
