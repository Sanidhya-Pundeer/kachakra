import 'package:carousel_slider/carousel_slider.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/payment_method_screen/razor_pay_api.dart';
import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_IndustryData.dart';
import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_data.dart';
import 'package:courier_delivery/presentation/replace_bin_screen/widgets/bin_IndustryWidget.dart';
import 'package:courier_delivery/presentation/replace_bin_screen/widgets/bin_widget.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/userData.dart';
import '../replace_bin_screen/widgets/waste_example_list.dart';
import 'controller/replace_bin_controller.dart';

class ReplaceBinScreen extends StatefulWidget {
  ReplaceBinScreen({Key? key}) : super(key: key);

  @override
  State<ReplaceBinScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<ReplaceBinScreen> {
  ReplaceBinController sendPackageController = Get.put(ReplaceBinController());

  List<String> familySize = ['1-2', '4-5', 'All'];
  List<String> locations = [
    'Kitchen',
    'Bathroom',
    'Bedroom',
    'Toilet',
    'Office'
  ];
  List<String> capacity = ['200 L', '660 L', '1100 L'];

  double totalPrice = 0.0;
  void _updatePrice(String price) {
    setState(() {
      totalPrice += double.parse(price);
    });
  }

  String? selectedFamilySize;
  String? selectedLocation;
  String? selectedCapacity;
  int bin_price = 0;
  int addon_price = 0;
  int total_price = 0;
  SharedPreferences? _prefs;

  void _onCapacityChanged(String? newValue) {
    setState(() {
      selectedCapacity = newValue;
      totalPrice = 0.0; // Reset total price
    });
  }

  void _onFamilySizeChanged(String? newValue) {
    setState(() {
      selectedFamilySize = newValue;
      selectedLocation = null; // Reset location
      totalPrice = 0.0; // Reset total price
    });
  }

  void _onLocationChanged(String? newValue) {
    setState(() {
      selectedLocation = newValue;
      totalPrice = 0.0; // Reset total price
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          statusBarIconBrightness: Brightness.dark),
    );
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
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
                        onTap: () {
                          onTapArrowleft4();
                        }),
                    centerTitle: true,
                    title: AppbarSubtitle1(text: "Replace Bin".tr),
                    styleType: Style.bgFillWhiteA700),
                body: SingleChildScrollView(
                  child: GetBuilder<ReplaceBinController>(
                    init: ReplaceBinController(),
                    builder: (controller) => Container(
                      child: Padding(
                        padding: getPadding(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomImageView(
                                  svgPath: ImageConstant.imgTimeLineIcon,
                                ),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Bin Locaion".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtSubheadline),
                                          SizedBox(
                                            height: getVerticalSize(8),
                                          ),
                                          CustomTextFormField(
                                            alignment: Alignment.center,
                                            hintText: UserData.userAddress.tr,
                                            readOnly: true,
                                            maxLines:
                                                2, // Set to null or a value greater than 1 for multiple lines
                                            suffix: Container(
                                              margin: getMargin(
                                                  left: 15,
                                                  top: 15,
                                                  right: 15,
                                                  bottom: 15),
                                              child: CustomImageView(
                                                onTap: () async {},
                                                svgPath: ImageConstant
                                                    .imgLocationBlack900,
                                              ),
                                            ),
                                            suffixConstraints: BoxConstraints(
                                              maxHeight: getVerticalSize(54),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                                padding: getPadding(top: 16),
                                child: Text("Discover your Bin!".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSubheadline)),
                            if (UserData.userType == 'industry')
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: getMargin(top: 16),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedCapacity,
                                            onChanged: _onCapacityChanged,
                                            items: [
                                              DropdownMenuItem(
                                                value: null,
                                                child: Text(
                                                    'Select Bin Capacity!'), // Placeholder text
                                              ),
                                              ...capacity.map((String item) {
                                                return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 2,
                                                          height: 20,
                                                          color:
                                                              Color(0xFF03BB85),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 8),
                                                        ),
                                                        Text(item),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                            underline: Container(),
                                            style: AppStyle.txtAvenirRegular16,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: ColorConstant.primaryAqua,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(16),
                                    ),
                                    if (selectedCapacity == '200 L')
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: ColorConstant.highlighter
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: BinIndustryWidget(
                                            capacity: selectedCapacity!,
                                            onPriceSelected: _updatePrice,
                                          )),
                                    if (selectedCapacity == '660 L')
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: ColorConstant.highlighter
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: BinIndustryWidget(
                                            capacity: selectedCapacity!,
                                            onPriceSelected: _updatePrice,
                                          )),
                                    if (selectedCapacity == '1100 L')
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: ColorConstant.highlighter
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: BinIndustryWidget(
                                            capacity: selectedCapacity!,
                                            onPriceSelected: _updatePrice,
                                          )),
                                  ],
                                ),
                              ),
                            if (UserData.userType == 'household')
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: getMargin(top: 16),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedFamilySize,
                                            onChanged: _onFamilySizeChanged,
                                            items: [
                                              DropdownMenuItem(
                                                value: null,
                                                child: Text(
                                                    'Select Family Size!'), // Placeholder text
                                              ),
                                              ...familySize.map((String item) {
                                                return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 2,
                                                          height: 20,
                                                          color:
                                                              Color(0xFF03BB85),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 8),
                                                        ),
                                                        Text(item),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                            underline: Container(),
                                            style: AppStyle.txtAvenirRegular16,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: ColorConstant.primaryAqua,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedLocation,
                                            onChanged: _onLocationChanged,
                                            items: [
                                              DropdownMenuItem(
                                                value: null,
                                                child: Text(
                                                    'Select Location!'), // Placeholder text
                                              ),
                                              ...locations.map((String item) {
                                                return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 2,
                                                          height: 20,
                                                          color:
                                                              Color(0xFF03BB85),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 8),
                                                        ),
                                                        Text(item),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                            underline: Container(),
                                            style: AppStyle.txtAvenirRegular16,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: ColorConstant.primaryAqua,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(16),
                                    ),
                                    if ((selectedFamilySize == '1-2' ||
                                            selectedFamilySize == 'All') &&
                                        selectedLocation == 'Kitchen')
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.highlighter
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          children: [
                                            if (selectedFamilySize == '1-2' &&
                                                selectedLocation == 'Kitchen')
                                              BinWidget(
                                                familySize: "1-2",
                                                location: "Kitchen",
                                                onPriceSelected: _updatePrice,
                                              ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            if (selectedFamilySize == 'All' &&
                                                selectedLocation == 'Kitchen')
                                              BinWidget(
                                                familySize: "1-2",
                                                location: "Kitchen",
                                                onPriceSelected: _updatePrice,
                                              ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if ((selectedFamilySize == '4-5' ||
                                            selectedFamilySize == 'All') &&
                                        selectedLocation == 'Kitchen')
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.highlighter
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          children: [
                                            BinWidget(
                                              familySize: "4-5",
                                              location: "Kitchen",
                                              onPriceSelected: _updatePrice,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if ((selectedFamilySize == '1-2' ||
                                            selectedFamilySize == '4-5' ||
                                            selectedFamilySize == 'All') &&
                                        (selectedLocation == 'Bathroom' ||
                                            selectedLocation == 'Bedroom' ||
                                            selectedLocation == 'Toilet' ||
                                            selectedLocation == 'Office'))
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.highlighter
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          children: [
                                            BinWidget(
                                              familySize: "All",
                                              location:
                                                  "Bathroom, Bedroom, Toilet, Office",
                                              onPriceSelected: _updatePrice,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            if (UserData.userType == 'industry')
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 300.0,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  onPageChanged: (index, reason) {
                                    setState(() {});
                                  },
                                ),
                                items: IndustryData.getBinData().map((bin) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                bin.image!,
                                                width: 50,
                                                height: 50,
                                              ),
                                              Text("Color: ${bin.color}"),
                                              Text("Material: ${bin.material}"),
                                              Text(
                                                  "Dimensions: ${bin.dimensions}"),
                                              Text("Brand: ${bin.make!}"),
                                              Text("Location: ${bin.location}"),
                                              Text("Price: Rs. ${bin.price}"),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _updatePrice(bin.price!);
                                                  },
                                                  child: Text("Add")),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            if (UserData.userType == 'household')
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 310.0,
                                  autoPlay: true,
                                  enlargeCenterPage: false,
                                  aspectRatio: 16 / 9,
                                  onPageChanged: (index, reason) {
                                    setState(() {});
                                  },
                                ),
                                items: BinData.getBinData().map((bin) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        width: 400,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  bin.image!,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                Text("Color: ${bin.color}"),
                                                Text(
                                                    "Material: ${bin.material}"),
                                                Text(
                                                    "Dimensions: ${bin.dimensions}"),
                                                Text("Brand: ${bin.make!}"),
                                                Text(
                                                    "Household Size: ${bin.size}"),
                                                Text(
                                                    "Location: ${bin.location}"),
                                                Text("Price: Rs. ${bin.price}"),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _updatePrice(bin.price!);
                                                    },
                                                    child: Text("Add")),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: CustomButton(
                    height: getVerticalSize(54),
                    text: "Pay: ₹ " + totalPrice.toString(),
                    margin: getMargin(left: 16, right: 16, bottom: 40),
                    onTap: () async {
                      await _prefs?.setString(
                          'payment', totalPrice.toString() ?? '');
                      if (selectedFamilySize != null ||
                          selectedCapacity != null) {
                        onTapNext();
                      }
                      ;
                    }))));
  }

  onTapDeliverto() {
    Get.toNamed(
      AppRoutes.selectDeliveryAddressScreen,
    );
  }

  onTapPickup() {
    Get.toNamed(
      AppRoutes.selectPickupAddressScreen,
    );
  }

  onTapNext() {
    Get.toNamed(
      AppRoutes.paymentMethodScreen,
    );
    // sendPackageController.generateRequest();
  }

  onTapArrowleft4() {
    Get.back();
  }
}
