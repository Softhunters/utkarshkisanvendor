import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../widgets/text_fields.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final controller =
          Provider.of<DashboardController>(context, listen: false);
      controller.addressController.text =
          controller.profileData?.sellerDetails?.address ?? "";
      controller.pinCodeController.text =
          controller.profileData?.sellerDetails?.pinCode ?? "";
      controller.gstNumberController.text =
          controller.profileData?.sellerDetails?.gstinNumber ?? "";
      controller.selectedIdProof =
          controller.profileData?.sellerDetails?.idProofType ?? "";

      controller.selectedCountryId =
          controller.profileData?.sellerDetails?.country ?? "";
      controller.selectedStateId =
          controller.profileData?.sellerDetails?.state ?? "";
      controller.selectedCityId =
          controller.profileData?.sellerDetails?.city ?? "";

      controller.selectedPdfFileUrl =
          "${serverURL}/${controller.profileData?.sellerDetails?.proofImage}";
      controller.gstPdfUrl =
          "${serverURL}/${controller.profileData?.sellerDetails?.gstinImage}";

      await controller.getState(controller.selectedCountryId!);
      await controller.getCity(controller.selectedStateId!);
    });
  }

  String? getValidDropdownValue(List<String> ids, String? selectedId) {
    return ids.contains(selectedId) ? selectedId : null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (context, controller, _) {
        final width = MediaQuery.of(context).size.width;

        final countryIds =
            controller.countries.map((e) => e.id.toString()).toList();
        final stateIds =
            controller.stateList.map((e) => e.id.toString()).toList();
        final cityIds =
            controller.cityList.map((e) => e.id.toString()).toList();
        final idProofs = controller.idProofItems;

        final selectedCountry =
            getValidDropdownValue(countryIds, controller.selectedCountryId);
        final selectedState =
            getValidDropdownValue(stateIds, controller.selectedStateId);
        final selectedCity =
            getValidDropdownValue(cityIds, controller.selectedCityId);
        final selectedIdProof =
            getValidDropdownValue(idProofs, controller.selectedIdProof);

        return Scaffold(
          appBar: AppBar(title: Text("Profile")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText("Address"),
                AppTextFormWidget(
                  hintText: "Enter Your Address",
                  controller: controller.addressController,
                  focusNode: controller.address,
                  keyBoardType: TextInputType.streetAddress,
                  maxLines: 2,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter address" : null,
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.divideColor,
                          ) ??
                      TextStyle(color: AppColors.divideColor),
                ),
                const SizedBox(height: 20),
                buildText("Country"),
                buildDropdown<String>(
                  value: selectedCountry,
                  items: controller.countries
                      .map((e) => DropdownMenuItem(
                          value: e.id.toString(), child: Text(e.name ?? "")))
                      .toList(),
                  onChanged: (val) {
                    controller.selectedCountryId = val!;
                    controller.getState(val);
                  },
                ),
                const SizedBox(height: 10),
                buildText("State"),
                buildDropdown<String>(
                  value: selectedState,
                  items: controller.stateList
                      .map((e) => DropdownMenuItem(
                          value: e.id.toString(), child: Text(e.name ?? "")))
                      .toList(),
                  onChanged: (val) {
                    controller.selectedStateId = val!;
                    controller.getCity(val);
                  },
                ),
                const SizedBox(height: 10),
                buildText("City"),
                buildDropdown<String>(
                  value: selectedCity,
                  items: controller.cityList
                      .map((e) => DropdownMenuItem(
                          value: e.id.toString(), child: Text(e.name ?? "")))
                      .toList(),
                  onChanged: (val) => controller.selectedCityId = val!,
                ),
                const SizedBox(height: 20),
                buildText("Zip Code"),
                AppTextFormWidget(
                  keyBoardType: TextInputType.number,
                  controller: controller.pinCodeController,
                  maxLength: 6,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter zip code" : null,
                  hintText: "Zip Code",
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.divideColor,
                          ) ??
                      TextStyle(color: AppColors.divideColor),
                ),
                const SizedBox(height: 20),
                buildText("Choose ID Type"),
                buildDropdown<String>(
                  value: selectedIdProof,
                  items: idProofs
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => controller.selectedIdProof = val!,
                ),
                const SizedBox(height: 20),
                buildText("Upload Your ID (PDF)"),
                buildPdfPicker(
                    controller.selectedPdfFile,
                    controller.selectedPdfFileUrl,
                    () => controller.pickPdfFile(),
                    "Upload Your ID"),
                if (controller.selectedPdfFile != null ||
                    controller.selectedPdfFileUrl != null)
                  ElevatedButton.icon(
                    onPressed: () => controller.openPdfViewer(context),
                    icon: Icon(Icons.picture_as_pdf),
                    label: Text("View ID"),
                  ),
                const SizedBox(height: 20),
                buildText("GST Number"),
                AppTextFormWidget(
                  keyBoardType: TextInputType.number,
                  controller: controller.gstNumberController,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter GST Number" : null,
                  hintText: "Enter Your GST Number",
                  hintStyle: (Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.divideColor)) ??
                      TextStyle(color: AppColors.divideColor),
                ),
                const SizedBox(height: 20),
                buildText("Upload Your GSTIN (PDF)"),
                buildPdfPicker(controller.gstPdf, controller.gstPdfUrl,
                    () => controller.pickPdfFileForGST(), "Upload Your GSTIN"),
                if (controller.gstPdf != null || controller.gstPdfUrl != null)
                  ElevatedButton.icon(
                    onPressed: () => controller.openPdfViewerForGST(context),
                    icon: Icon(Icons.picture_as_pdf),
                    label: Text("View GSTIN"),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(16),
            child: AppButton(
              title: "Update Profile",
              onTap: () async {
                final idProof = await controller.fileToMultipart(
                    controller.selectedPdfFile, "proof_image");
                final gstPdf = await controller.fileToMultipart(
                    controller.gstPdf, "gstin_image");
                ProfileUpdateRequest data = ProfileUpdateRequest(
                  address: controller.addressController.text,
                  country: controller.selectedCountryId,
                  state: controller.selectedStateId,
                  city: controller.selectedCityId,
                  pinCode: controller.pinCodeController.text,
                  idProofType: controller.selectedIdProof,
                  gstInNumber: controller.gstNumberController.text,
                  idProofPdf: idProof,
                  gSTInPDF: gstPdf,
                );
                await controller.updateProfileVendor(data, (success) {
                  if (success) {

                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildText(String text) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w500));
  }

  Widget buildDropdown<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        value: value,
        isExpanded: true,
        items: items,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 14),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.textFieldColor,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget buildPdfPicker(
      dynamic file, String? url, VoidCallback onTap, String hintText) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: AppTextFormWidget(
          hintText:
              file?.path.split('/').last ?? url?.split('/').last ?? hintText,
          controller:
              TextEditingController(text: file?.path.split('/').last ?? ""),
          sufixIcon: Icon(Icons.file_upload),
          validator: (value) => file == null && (url == null || url.isEmpty)
              ? "Please upload a PDF"
              : null,
          hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.divideColor) ??
              TextStyle(color: AppColors.divideColor),
        ),
      ),
    );
  }
}
