import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/view/Dashboard_view.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:utkrashvendor/widgets/text_fields.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../viewModal/variant_response.dart';

class EditProductView extends StatefulWidget {
  VariantList? data;

  EditProductView(this.data, {super.key});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
// default
  final List<String> statusOptions = ['Active', 'Deactive'];

  @override
  void initState() {
    super.initState();

    final controller = Provider.of<DashboardController>(context, listen: false);
    controller.priceController.text = (widget.data?.price ?? '').toString();
    controller.quantityController.text =
        (widget.data?.quantity ?? '').toString();
    controller.additionalInfoController.text =
        (widget.data?.additionalInfo ?? '').toString();

    if (widget.data?.status == 1) {
      controller.selectedStatus = 'Active';
    } else {
      controller.selectedStatus = 'Deactive';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Consumer<DashboardController>(
        builder: (context, controller, _) => Scaffold(
              appBar: AppBar(
                title: Text("Edit Product"),
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
                        "$imageURL${widget.data?.productApi?.image ?? ''}",
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
                                      widget.data?.productApi?.name != null
                                          ? widget.data?.productApi?.name ?? ""
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

                              // Row(
                              //   mainAxisAlignment:
                              //   MainAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       "MRP: ₹${widget.data?.price ?? " "}",
                              //       maxLines: 1,
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .labelSmall
                              //           ?.copyWith(
                              //           fontSize: 12,
                              //           fontWeight:
                              //           FontWeight.w600),
                              //     ),
                              //     const SizedBox(width: 2),
                              //
                              //
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Regular Price: ₹${widget.data?.productApi?.regularPrice ?? " "}",
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
                                            "Sale Price: ₹${widget.data?.productApi?.salePrice ?? " "}",
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
                                            "Variant: ${widget.data?.productApi?.variantDetails ?? " "}",
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
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          showDialog(
                                            context: context,
                                            builder: (context) {


                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                title: const Text("Add Quantity"),
                                                content: TextField(
                                                  controller: controller.addquantityForVandorController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: const InputDecoration(
                                                    labelText: "Quantity",
                                                    border: OutlineInputBorder(),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context), // Close dialog
                                                    child: const Text("Cancel"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async{
                                                      if (controller.addquantityForVandorController.text.isNotEmpty) {
                                                        AddQuantityModel data1 = AddQuantityModel(
                                                            quantity: controller.addquantityForVandorController.text??'',
                                                            id: widget.data?.id.toString()
                                                        );

                                                        await    controller.addQuantityVandorDetails(data1,(value){});
                                                        await controller.getVariantData();
                                                        // 🟢 Find the updated variant from the list using ID
                                                        final updatedVariant = controller.variant?.variantList?.firstWhereOrNull(
                                                                (variant) => variant.id == widget.data?.id);

                                                        if (updatedVariant != null) {
                                                          controller.quantityController.text = (updatedVariant.quantity ?? '').toString();
                                                        }

                                                        controller.addquantityForVandorController.clear();
                                                        Navigator.pop(context);
                                                      } else {
                                                        // Show validation error
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(content: Text("Please enter a quantity")),
                                                        );
                                                        controller.addquantityForVandorController.clear();
                                                      }
                                                    },
                                                    child: const Text("Add"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child:Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color:AppColors.grey1)
                                          ),

                                          child:Text("Add quantity",style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryDarkColor),),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
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
                              controller: controller.priceController,
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
                                enable: false,
                                hintText: "Quantity",
                                controller: controller.quantityController,
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
                                controller: controller.additionalInfoController,
                                hintStyle: TextStyle(fontSize: 12)),
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
                              "Status",
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
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  value: controller.selectedStatus,
                                  items: statusOptions
                                      .map((status) => DropdownMenuItem<String>(
                                    value: status,
                                    child: Text(
                                      status,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (value) async {
                                    if (value == null) return;

                                    setState(() {
                                      controller.selectedStatus = value;
                                    });
                                    // Call your controller or API to update status
                                    final newStatus = value == 'Active' ? 1 : 0;
                                    // Example:

                                    // await controller.updateProductStatus(widget.data!.id, newStatus);
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 50,
                                    width: 200,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                      title: "Update",
                      onTap: () {
                        final data = VariantUpdateModel(
                            productId: widget.data?.productId.toString(),
                            price: controller.priceController.text,
                            quantity: controller.quantityController.text,
                            additionalInfo:
                                controller.additionalInfoController.text,
                            status: controller.selectedStatus == "Active"
                                ? "1"
                                : "0");

                        controller.updateVariantDetails(data, (value) async {
                          if (value) {
                            // Get.offAll(()=>)
                            await controller.getVariantData();
                            await controller.getHomeData();
                            Get.off(() => DashboardView());
                          }
                        });
                      }),
                ),
              ),
            ));
  }
}
