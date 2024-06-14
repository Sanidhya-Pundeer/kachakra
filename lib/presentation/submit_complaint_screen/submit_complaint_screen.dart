
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/core/utils/validation_functions.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_floating_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller/submit_complaint_controller.dart';

class SubmitComplaintScreen extends StatefulWidget {
  const SubmitComplaintScreen({Key? key}) : super(key: key);

  @override
  State<SubmitComplaintScreen> createState() => _SubmitComplaintScreenState();
}

class _SubmitComplaintScreenState extends State<SubmitComplaintScreen> {
  SubmitComplaintController controller = Get.put(SubmitComplaintController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Uint8List> _selectedImages = [];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.whiteA700,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

  Future<List<Uint8List>> _pickMultiplePhotos() async {
    List<Uint8List> result = [];

    // try {
    //   List<Asset> images = await MultiImagePicker.pickImages(
    //     maxImages: 5,
    //     enableCamera: true,
    //     selectedAssets: [],
    //     cupertinoOptions: CupertinoOptions(
    //       selectionFillColor: "#000000",
    //       selectionTextColor: "#000000",
    //       selectionCharacter: '✓',
    //     ),
    //     materialOptions: MaterialOptions(
    //       actionBarColor: "#000000",
    //       actionBarTitle: "Select Images",
    //       allViewTitle: "All Photos",
    //       useDetailsView: false,
    //       selectCircleStrokeColor: "#000000",
    //     ),
    //   );
    //
    //   result = await controller.processImages(images);
    // }
    // catch (e) {
    //   print("Error picking images: $e");
    // }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: ColorfulSafeArea(
        color: ColorConstant.whiteA700,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstant.whiteA700,
          appBar: CustomAppBar(
            height: getVerticalSize(79),
            leadingWidth: 42,
            leading: AppbarImage(
              height: getSize(24),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 18, top: 29, bottom: 26),
              onTap: onTapArrowleft19,
            ),
            centerTitle: true,
            title: AppbarSubtitle1(text: "Complaints".tr),
            styleType: Style.bgFillWhiteA700,
          ),
          body: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Container(
                width: double.maxFinite,
                margin: getMargin(top: 8),
                padding: getPadding(all: 16),
                decoration: AppDecoration.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomFloatingEditText(
                      controller: controller.nameController,
                      labelText: "lbl_name".tr,
                      hintText: "lbl_name".tr,
                      shape: FloatingEditTextShape.RoundedBorder8,
                      padding: FloatingEditTextPadding.PaddingT17,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            (!isValidEmail(value, isRequired: true))) {
                          return "Please enter valid text";
                        }
                        return null;
                      },
                    ),
                    CustomFloatingEditText(
                      controller: controller.addressController,
                      labelText: "Street Address".tr,
                      hintText: "Street Address".tr,
                      shape: FloatingEditTextShape.RoundedBorder8,
                      padding: FloatingEditTextPadding.PaddingT17,
                      margin: getMargin(top: 16),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            (!isValidEmail(value, isRequired: true))) {
                          return "Please enter valid text";
                        }
                        return null;
                      },
                    ),
                    CustomFloatingEditText(
                      controller: controller.landmarkController,
                      labelText: "Landmark".tr,
                      hintText: "Landmark".tr,
                      shape: FloatingEditTextShape.RoundedBorder8,
                      padding: FloatingEditTextPadding.PaddingT17,
                      margin: getMargin(top: 16),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            (!isValidEmail(value, isRequired: true))) {
                          return "Please enter valid text";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: getVerticalSize(16),
                    ),
                    phone_number_field(
                      controller.phoneNumberController,
                          (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Enter valid number";
                        }
                        return null;
                      },
                    ),
                    CustomFloatingEditText(
                      controller: controller.problemController,
                      labelText: "What is the Problem?".tr,
                      hintText: "Your Problem".tr,
                      shape: FloatingEditTextShape.RoundedBorder8,
                      padding: FloatingEditTextPadding.PaddingT17,
                      margin: getMargin(top: 16),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            (!isValidEmail(value, isRequired: true))) {
                          return "Please enter valid text";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: getVerticalSize(16)),
                    ElevatedButton(
                      onPressed: () async {
                        var status = await Permission.photos.request();
                        if (status.isGranted) {
                          List<Uint8List> selectedPhotos =
                          await _pickMultiplePhotos();

                          setState(() {
                            _selectedImages.addAll(selectedPhotos);
                          });
                        } else {
                          print("Permission denied");
                        }
                      },
                      child: Text("Upload Photos"),
                    ),
                    SizedBox(height: getVerticalSize(16)),
                    if (_selectedImages.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Uploaded Photos:"),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (Uint8List imageBytes in _selectedImages)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the horizontal spacing
                                  child: Image.memory(
                                    imageBytes,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          )

                        ],
                      ),
                    Spacer(),
                    CustomButton(
                      height: getVerticalSize(54),
                      text: "Submit".tr,
                      margin: getMargin(bottom: 24),
                      onTap: onTapSave,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapSave() {
    controller.submitComplaint();
  }

  onTapArrowleft19() {
    Get.back();
  }
}
