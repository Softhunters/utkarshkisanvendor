import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:utkrashvendor/widgets/text_fields.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../CategoryProduct/model/product_detail_model.dart';
import '../viewModal/variant_response.dart';
import 'Dashboard_view.dart';

class AddProductView extends StatefulWidget {
  Products? data;

  AddProductView(this.data, {super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
// default
  final List<String> statusOptions = ['Active', 'Deactive'];

  @override
  void initState() {
    super.initState();

    final controller = Provider.of<DashboardController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Consumer<DashboardController>(
        builder: (context, controller, _) => Scaffold(
              appBar: AppBar(
                title: Text("Add Seller"),
                centerTitle: false,
              ),
              body: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "$imageURL${widget.data?.image ?? ''}",
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFCF7EB),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width * 0.9,
                                    child: Text(
                                      widget.data?.name != null
                                          ? widget.data?.name ?? ""
                                          : "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                          color: AppColors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Regular Price: ₹${widget.data?.regularPrice ?? " "}",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                        fontSize: 14,
                                        color: AppColors.primaryBlack),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Sale Price: ₹${widget.data?.salePrice ?? " "}",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                        fontSize: 12,
                                        color: AppColors.redColor),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Variant: ${widget.data?.varaintDetail ?? " "}",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                        fontSize: 14,
                                        color: AppColors.primaryBlack),
                                  ),
                                ],
                              ),
                              // if(controller.productDetail?.stockStatus != "instock")
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.data?.stockStatus == "instock"
                                      ? "In Stock"
                                      : "Out Of Stock",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: widget.data?.stockStatus ==
                                          "instock"
                                          ? AppColors.green
                                          : AppColors.redColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                  color: AppColors.primaryBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            AppTextFormWidget(
                              hintText: "Price",
                              controller: controller.priceAddController,
                              hintStyle: TextStyle(fontSize: 12),
                              keyBoardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                  color: AppColors.primaryBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            AppTextFormWidget(
                                hintText: "Quantity",
                                controller: controller.quantityAddController,
                                hintStyle: TextStyle(fontSize: 12),
                                keyBoardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Additional Info",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                  color: AppColors.primaryBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            AppTextFormWidget(
                                hintText: "Additional Info",
                                controller:
                                controller.additionalInfoAddController,
                                hintStyle: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: AppButton(
                      title: "Add",
                      onTap: () {
                        final data = VariantAddModel(
                          productId: widget.data?.id.toString(),
                          price: controller.priceAddController.text,
                          quantity: controller.quantityAddController.text,
                          additionalInfo:
                              controller.additionalInfoAddController.text,
                        );

                        controller.addVariantDetails(data, (value) async {

                          if (value) {
                            // Get.offAll(()=>)
                            await controller.getVariantData();
                            await controller.getHomeData();
                            controller.priceAddController.clear();
                            controller.quantityAddController.clear();
                            controller.additionalInfoAddController.clear();

                            Get.off(() => DashboardView());
                          }
                        });
                      }),
                ),
              ),
            ));
  }
}
