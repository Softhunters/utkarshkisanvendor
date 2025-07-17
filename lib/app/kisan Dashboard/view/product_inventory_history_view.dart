import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import 'package:utkrashvendor/common_widgets/app_colors.dart';

import '../../../common_widgets/urls.dart';
import '../../../widgets/cache_network_image.dart';
import '../viewModal/order_history_by_product.dart';

class ProductInventoryHistoryView extends StatefulWidget {
  final VendorOrderHistoryByProductResult? data;

  const ProductInventoryHistoryView(this.data, {super.key});

  @override
  State<ProductInventoryHistoryView> createState() =>
      _ProductInventoryHistoryViewState();
}

class _ProductInventoryHistoryViewState
    extends State<ProductInventoryHistoryView> {
  Future<void> downloadExcelSheet() async {
    final controller = Provider.of<DashboardController>(context, listen: false);
    final history = controller.productInventoryHistory ?? [];

    if (history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No data available to download")),
      );
      return;
    }

    // Request storage permission
    if (await Permission.storage.request().isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Storage permission is required")),
      );
      return;
    }

    // Create Excel
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['InventoryHistory'];

    // Header row
    sheetObject.appendRow([
      TextCellValue('S No.'),
      TextCellValue('Product Name'),
      TextCellValue('Order No'),
      TextCellValue('Quantity'),
      TextCellValue('Date'),
    ]);

    // Data rows
    for (int i = 0; i < history.length; i++) {
      final item = history[i];
      final date = item.createdAt != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(item.createdAt!))
          : '-';
      final quantity =
          item.type == "add" ? "+${item.quantity}" : "-${item.quantity}";

      sheetObject.appendRow([
        TextCellValue('${i + 1}'),
        TextCellValue(widget.data?.productApi?.name ?? ''),
        TextCellValue(item.orderNo ?? ''),
        TextCellValue(quantity),
        TextCellValue(date),
      ]);
    }

    // Save Excel to file
    final fileBytes = excel.encode();
    final directory = await getExternalStorageDirectory();
    final downloadsPath =
        "${directory?.path}/Inventory_${widget.data?.productApi?.name ?? 'product'}.xlsx";

    final file = File(downloadsPath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Downloaded to: $downloadsPath")),
    );

    // ✅ Open the file after download
    final result = await OpenFile.open(file.path);
    print("Open result: ${result.message}");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Consumer<DashboardController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Inventory History"),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.2,
                            child: MyCacheNetworkImages(
                              imageUrl:
                                  "$imageURL${widget.data?.productApi?.image}",
                              width: 100,
                              height: 110,
                              radius: 10,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data?.productApi?.name ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "MRP: ${widget.data?.productApi?.regularPrice ?? ''}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  "Your Selling Price: ₹${widget.data?.price ?? ''}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total Spent",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                ),
                                Text(
                                  (widget.data?.totalMinus).toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total Add",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                ),
                                Text(
                                  (widget.data?.totalAdd).toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Remaining Qty.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                ),
                                Text(
                                  (widget.data?.quantity).toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Inventory History",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBlack,
                                  ),
                        ),
                        ElevatedButton.icon(
                          onPressed: downloadExcelSheet,
                          icon: Icon(Icons.download),
                          label: Text("Download Excel"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: controller.productInventoryHistory?.length != 0
                          ? DataTable(
                              headingRowColor: MaterialStateProperty.all(
                                AppColors.primaryColor.withOpacity(0.1),
                              ),
                              headingTextStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              columns: [
                                DataColumn(
                                  label: Text('S No.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryBlack,
                                          )),
                                ),
                                DataColumn(
                                  label: Text('Order No',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryBlack,
                                          )),
                                ),
                                DataColumn(
                                  label: Text('Quantity',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryBlack,
                                          )),
                                ),
                                DataColumn(
                                  label: Text('Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryBlack,
                                          )),
                                ),
                              ],
                              rows: List.generate(
                                controller.productInventoryHistory!.length,
                                (index) {
                                  final item = controller
                                      .productInventoryHistory![index];
                                  final dateTime =
                                      DateTime.tryParse(item.createdAt ?? '');
                                  final formattedDate = dateTime != null
                                      ? DateFormat('dd-MM-yyyy')
                                          .format(dateTime)
                                      : '-';

                                  return DataRow(cells: [
                                    DataCell(Text('${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryBlack,
                                            ))),
                                    DataCell(Text(item.orderNo ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryBlack,
                                            ))),
                                    DataCell(Text(
                                        item.type == "add"
                                            ? "+${item.quantity}"
                                            : "-${item.quantity}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: item.type == "add"
                                                  ? AppColors.primaryColor
                                                  : AppColors.redColor,
                                            ))),
                                    DataCell(Text(formattedDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryBlack,
                                            ))),
                                  ]);
                                },
                              ))
                          : Text('No data available',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBlack,
                                  )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
