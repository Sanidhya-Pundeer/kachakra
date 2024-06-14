import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../home_container_page/controller/home_container_controller.dart';
import '../home_container_page/models/corier_service_model.dart';

class CalculatePriceScreen extends StatefulWidget {
  final String? searchKeyword;

  CalculatePriceScreen({Key? key, this.searchKeyword}) : super(key: key);

  @override
  State<CalculatePriceScreen> createState() => _CalculatePriceScreenState();
}

class _CalculatePriceScreenState extends State<CalculatePriceScreen> {
  HomeContainerController controller = Get.put(HomeContainerController());

  @override
  Widget build(BuildContext context) {
    List<CourierService> filteredData = getFilteredData();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: getVerticalSize(20),
          ),
          Text(
            "Results".tr,
            style: AppStyle.txtSFProTextBold20,
          ),
          SizedBox(
            height: getVerticalSize(8),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                      color: ColorConstant.gray300,
                    ),
                    bottom: BorderSide(
                      color: ColorConstant.gray300,
                    ))),
            child: Padding(
              padding: getPadding(all: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Search for".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextRegular17),
                    ],
                  ),
                  CustomImageView(
                      svgPath: ImageConstant.imgArrowleftBlack900,
                      height: getSize(24),
                      width: getSize(24),
                      alignment: Alignment.center),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                  widget.searchKeyword!.toLowerCase().tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextRegular17),
                    ],
                  )
                ],
              ),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.only(bottom: 18.0),
            primary: false,
            shrinkWrap: true,
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              CourierService data = filteredData[index];
              return Container(
                  margin: getMargin(
                      left: 16, top: 16, right: 16),
                  padding: getPadding(
                      left: 16, top: 18, right: 16, bottom: 18),
                  decoration: AppDecoration.fillGray50
                      .copyWith(
                      borderRadius:
                      BorderRadiusStyle.roundedBorder8),
                  child: GestureDetector(
                    onTap: () {
                      showServiceDetail(data);
                    },
                    child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(data.subtitle!,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtSFProTextRegular14),
                                Container(
                                  width: 0.5 * MediaQuery.of(context).size.width,
                                  child: Text( "Deals in: " +
                                    data.rating!,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtOutfitRegular14,
                                  ),
                                ),
                              ]),
                          Column(
                              children: [
                                Text(data.charges!,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtOutfitRegular14),
                                GestureDetector(
                                    onTap: () {
                                      launchGoogleMaps(data);
                                    },
                                    child: Text(
                                        "Get Directions->",
                                        textAlign:
                                        TextAlign.left,
                                        style: AppStyle
                                            .txtOutfitRegular14Green)),
                              ]),
                        ]),
                  ));
            },
          )
        ],
      ),
    );
  }

  List<CourierService> getFilteredData() {
    String searchKeyword =
    widget.searchKeyword!.toLowerCase();
    return controller.nearbyStations.where((data) {
      return data.subtitle!
          .toLowerCase()
          .contains(searchKeyword) ||
          data.discription!
              .toLowerCase()
              .contains(searchKeyword) ||
          data.rating!
              .toLowerCase()
              .contains(searchKeyword) ||
          data.charges!
              .toLowerCase()
              .contains(searchKeyword);
    }).toList();
  }

  onTapPackage() {
    Get.toNamed(
      AppRoutes.calculatePriceOneScreen,
    );
  }

  showServiceDetail(CourierService data) {
    Get.toNamed(
      AppRoutes.repairServiceDetailsScreen,
      arguments: {
        'subtitle': data.subtitle,
        'discription': data.discription,
        'charges': data.charges,
        'rating': data.rating,
        'long': data.long,
        'lat': data.lat,
        // Add more data as needed
      },
    );
  }

  void launchGoogleMaps(CourierService data) {
    double latitude = data.lat!;
    double longitude = data.long!;


    MapsLauncher.launchCoordinates(
      latitude,
      longitude,
      data.subtitle!, // Replace with a suitable title for the marker
    );
  }
}
