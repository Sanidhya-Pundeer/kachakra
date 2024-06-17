import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/mswDriverData.dart';
import 'package:courier_delivery/data/userData.dart';
import 'package:courier_delivery/presentation/send_package_screen/send_package_screen.dart';
import 'package:courier_delivery/presentation/show_loading_screen/loading_screen_controller.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_icon_button.dart';
import 'package:courier_delivery/presentation/send_package_screen/controller/send_package_controller.dart';
import 'package:courier_delivery/presentation/send_package_screen/models/card_item_list.dart';
import 'package:courier_delivery/presentation/show_loading_screen/linear_progress_bar.dart';

import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:firebase_core/firebase_core.dart';

import 'loading_screen_controller.dart';

class ShowLoadingScreen extends StatefulWidget {
  const ShowLoadingScreen({super.key});

  @override
  State<ShowLoadingScreen> createState() => _ShowLoadingScreenState();
}

class _ShowLoadingScreenState extends State<ShowLoadingScreen> {
  SendPackageController sendPackageController =
      Get.put(SendPackageController());

  late AnimationController controller;
  int _currentIndex = 0;

  // final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(31.344958, 75.575808),
  //   zoom: 14.4746,
  // );

  GoogleMapController? myMapController;
  loadingScreenController ctrl = loadingScreenController();

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyBv_iPnq5AaNhYzacndg_C9NgObIx-jiNU");
  final List<Polyline> polyline = [];
  List<LatLng> routeCoords = [];

  // final double lat1 = UserData.currentPosition.latitude;
  // final double long1 = UserData.currentPosition.longitude;
  double lat1 = 31.344259;
  double long1 = 75.575852;

//truck coordinates
  final double lat2 = 31.335791;
  final double long2 = 75.500304;

  computePath() async {
    LatLng origin = new LatLng(lat1, long1);
    LatLng end = new LatLng(lat2, long2);
    routeCoords.addAll((await googleMapPolyline.getCoordinatesWithLocation(
        origin: origin,
        destination: end,
        mode: RouteMode.driving)) as Iterable<LatLng>);

    setState(() {
      polyline.add(Polyline(
          polylineId: PolylineId('iter'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }

  bool showInitialContent = true;
  bool showInitialContent2 = true;
  @override
  void initState() {
    super.initState();
    getUserLocation();
    loadMarker();
    getUserLocation();
    computePath();

    Timer(
        Duration(seconds: 5),
        () => (setState(() {
              _setMapFitToTour(polyline);
              showInitialContent = false;
              _currentIndex = 1;
            })));
    Timer(Duration(seconds: 10),
        () => (setState(() => showInitialContent2 = false)));
  }

  Uint8List? markerImage;

  List<String> images = [
    'assets/images/black_pin.png',
    'assets/images/red_pin.png'
  ];

  List<Marker> _markers = <Marker>[];
  List<LatLng> _latLngs = <LatLng>[
    LatLng(31.344259, 75.575852),
    LatLng(31.335791, 75.500304)
  ];

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadMarker() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAssets(images[i].toString(), 100);
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latLngs[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(title: 'this is title marker')));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height * 0.50,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng((lat1 + lat2) / 2, (long1 + long2) / 2),
                  zoom: 12),
              zoomControlsEnabled: true,
              markers: Set<Marker>.of(_markers),
              polylines: polyline.toSet(),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
              },
            ),
          ),

          buildBackButton(),

          buildCurrentLocationIcon(),
          // buildLoadingBottomSheet(),
          buildLoadingBottomSheet(),

          // pickUpDetails()
        ],
      ),
    );
  }

  Widget buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 8),
        child: GestureDetector(
          onTap: onTapArrowleft4,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: SvgPicture.asset('assets/images/img_arrowleft.svg'),
          ),
        ),
      ),
    );
  }

  Widget buildCurrentLocationIcon() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 560, right: 12),
        child: GestureDetector(
          onTap: getUserLocation,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoadingBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.50,
        width: Get.width,
        // color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.white),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            showInitialContent
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Searching...'),
                      GestureDetector(
                        child: Image.asset('assets/images/search.gif'),
                        // onTap: () {},
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(),
                      Row(children: [
                        FutureBuilder<String>(
                          future: retrieveSelectedCard(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              String vehicle = snapshot.data!;
                              return Center(
                                child: getImageWidget(vehicle),
                              );
                            } else {
                              return Center(child: Text('No data available.'));
                            }
                          },
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Looking for",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "Collection Vehicle",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      LinearProgress(),
                      const SizedBox(),
                      Divider(
                        height: 40,
                        color: Colors.grey,
                      ),
                      Text(
                        "Pickup Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgTimeLineIcon,
                          ),
                          SizedBox(
                            width: getHorizontalSize(13),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Flexible(
                                    child: Container(
                                  child: Text(
                                    UserData.userCurrentAddress.isEmpty
                                        ? UserData.userAddress.tr
                                        : UserData.userCurrentAddress.tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  width: 300,
                                  height: 40,
                                )),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Container(
                                child: Text(
                                  "Drop Location",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "${ctrl.priceCalculator()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => {showCancelOptions()},
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff882f35)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xfff8f8f8)),
                                minimumSize:
                                    MaterialStateProperty.all(Size(150, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Color(0xfff8f8f8))))),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.lightGreen),
                                minimumSize:
                                    MaterialStateProperty.all(Size(150, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Color(0xfff8f8f8))))),
                          ),
                        ],
                      )
                    ],
                  ),
            showInitialContent2
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(),
                      Row(children: [
                        FutureBuilder<String>(
                          future: retrieveSelectedCard(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              String vehicle = snapshot.data!;
                              return Center(
                                child: getImageWidget(vehicle),
                              );
                            } else {
                              return Center(child: Text('No data available.'));
                            }
                          },
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Looking for",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "Collection Vehicle",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      LinearProgress(),
                      const SizedBox(),
                      Divider(
                        height: 40,
                        color: Colors.grey,
                      ),
                      Text(
                        "Pickup Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgTimeLineIcon,
                          ),
                          SizedBox(
                            width: getHorizontalSize(13),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Flexible(
                                    child: Container(
                                  child: Text(
                                    UserData.userCurrentAddress.isEmpty
                                        ? UserData.userAddress.tr
                                        : UserData.userCurrentAddress.tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  width: 300,
                                  height: 40,
                                )),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Container(
                                child: Text(
                                  "Drop Location",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "${ctrl.priceCalculator()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => {showCancelOptions()},
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff882f35)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xfff8f8f8)),
                                minimumSize:
                                    MaterialStateProperty.all(Size(150, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Color(0xfff8f8f8))))),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.lightGreen),
                                minimumSize:
                                    MaterialStateProperty.all(Size(150, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Color(0xfff8f8f8))))),
                          ),
                        ],
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pickup Vehicle on the way",
                              style: TextStyle(
                                color: Color(0xff204a84),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              )),
                          Container(
                            width: 70,
                            height: 32,
                            child: Center(
                                child: Text("1 min",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ))),
                            decoration: BoxDecoration(
                              color: Color(0xff204a84),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Start Pickup with PIN",
                              style: TextStyle(
                                color: Color(0xff595c65),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              )),
                          Container(
                            width: 70,
                            height: 32,
                            child: Center(
                                child: Text("5 8 7 9",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            decoration: BoxDecoration(
                              color: Color(0xfff6f7f9),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: Get.width * 0.9,
                        height: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("HR11AA1111",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text("Vehicle Name",
                                        style: TextStyle(
                                          color: Color(0xff5b5f68),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text("Driver Name",
                                        style: TextStyle(
                                          color: Color(0xff5b5f68),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: CircleAvatar(
                                    radius: 33,
                                    backgroundColor: Colors.lightGreen,
                                    child: Icon(
                                      Icons.supervised_user_circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  // onTap: null,
                                  onTap: () => {
                                    launchDialer(
                                        MswDriverData.phoneNumber.isEmpty
                                            ? "0000000000"
                                            : MswDriverData.phoneNumber)
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            Color(0xffeeeff1), // Border color
                                        width: 1.0, // Border width
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.call,
                                        color: Color(0xff80899a),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: Container(
                                      width: 300,
                                      height: 32,
                                      // color: Colors.white,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder16,
                                        border: Border.all(
                                          color:
                                              Color(0xffeeeff1), // Border color
                                          width: 1.0, // Border width
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Icon(
                                            Icons.message,
                                            color: Color(0xff80899a),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Driver Name',
                                            style: TextStyle(
                                                color: Color(0xff80899a)),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.black
                          color: Color(0xfff6f7f9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Pickup from",
                                style: TextStyle(
                                  color: Color(0xff595c65),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              // SizedBox(height: ,),
                              Text("Gurgaon",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          ElevatedButton(
                            onPressed: buildPickUpDetailsButton,
                            child: Text(
                              "Booking Details",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xfff6f7f9)),
                                minimumSize:
                                    MaterialStateProperty.all(Size(150, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Color(0xfff8f8f8))))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text(
                              "Pay Now",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.lightGreen),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Color(0xfff8f8f8))))),
                          ))
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget getImageWidget(String vehicle) {
    switch (vehicle) {
      case 'Mini-Truck':
        return Image.asset('assets/images/truck-small.png', width: 50);
      case 'Truck':
        return Image.asset('assets/images/truck-big.png', width: 70);
      case 'Single-Tanker':
        return Image.asset('assets/images/tanker-small.png', width: 50);
      case 'Double-Tanker':
        return Image.asset('assets/images/tanker-big.png', width: 70);
      default:
        return Image.asset('assets/images/truck-small.png', width: 50);
    }
  }

  buildPickUpDetailsButton() {
    return Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Location Details",
              style: TextStyle(
                  color: Color(0xff5c666f),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgTimeLineIcon,
                    ),
                    SizedBox(
                      width: getHorizontalSize(16),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Flexible(
                                  child: Container(
                                child: Text(
                                  UserData.userCurrentAddress.isEmpty
                                      ? UserData.userAddress.tr
                                      : UserData.userCurrentAddress.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                width: 260,
                                height: 40,
                              )),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Flexible(
                                  child: Container(
                                child: Text(
                                  "Drop Location",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                width: 260,
                                height: 40,
                              )),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Payment",
                  style: TextStyle(
                    color: Color(0xff5c666f),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text("${ctrl.priceCalculator()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {showCancelOptions()},
              child: Text(
                "Cancel Pickup",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff882f35)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xfff8f8f8)),
                  minimumSize: MaterialStateProperty.all(Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color(0xfff8f8f8))))),
            ),
          ),
        ],
      ),
    ));
  }

  showCancelOptions() {
    var formKey = GlobalKey<FormState>();
    String? error;
    String? gen;
    return Get.bottomSheet(Container(
        width: Get.width,
        height: Get.height * 0.5,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Why do you want to cancel?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                  child: Text(
                "Please provide the reason for cancellation",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              )),
            ),
            SizedBox(
              height: 14,
            ),
            MyForm(),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: showCancelButtons,
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightGreen),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Color(0xfff8f8f8))))),
                ))
          ],
        )));
  }

  void showCancelButtons() {
    Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.14,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Colors.white),
      child: Column(
        children: [
          Center(
              child: Text(
            "Are you sure you want to cancel this pickup?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: cancelSuccessfull,
                // onPressed: () => {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SendPackageScreen()),
                //   )
                // },
                child: Text(
                  "Cancel Pickup",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff882f35)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xfff8f8f8)),
                    minimumSize: MaterialStateProperty.all(Size(150, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xfff8f8f8))))),
              ),
              ElevatedButton(
                onPressed: popToLookingForVehicle,
                child: Text(
                  "Keep Searching",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen),
                    minimumSize: MaterialStateProperty.all(Size(150, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xfff8f8f8))))),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  void cancelSuccessfull() {
    Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.25,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xff27ae61),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Your pickup has been cancelled successfully",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          )),
          SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SendPackageScreen()),
                )
              },
              child: Text(
                "Done",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightGreen),
                  minimumSize: MaterialStateProperty.all(Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color(0xfff8f8f8))))),
            ),
          ),
        ],
      ),
    ));
  }

  void popToLookingForVehicle() {
    for (var i = 0; i < 2; i++) {
      Navigator.pop(context);
    }
  }

  onTapArrowleft4() {
    Get.back();
    UserData.userCurrentAddress = "";
  }

  navigateBackToSendPackageScreen(String message) {
    Get.offNamed(AppRoutes.sendPackageScreen, arguments: {'message': message});
  }

  launchDialer(String phoneNumber) async {
    // Remove non-numeric characters from the phone number
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
  }

  getUserLocation() async {
    List<Location> locations = await locationFromAddress(
        UserData.userCurrentAddress.isEmpty
            ? UserData.userAddress.tr
            : UserData.userCurrentAddress.tr);
    LatLng position =
        LatLng(locations.first.latitude, locations.first.longitude);

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(position, 13.8);
    myMapController?.animateCamera(cameraUpdate);
    print(locations);
  }

  void _setMapFitToTour(List<Polyline> p) {
    double minLat = p.first.points.first.latitude;
    double minLong = p.first.points.first.longitude;
    double maxLat = p.first.points.first.latitude;
    double maxLong = p.first.points.first.longitude;
    p.forEach((poly) {
      poly.points.forEach((point) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      });
    });
    myMapController?.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        20));
  }

  Future<String> retrieveSelectedCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String vehicle = prefs.getString('selectedCardItemName') ?? '';
    print("Vehicle selected: ${vehicle}");
    return vehicle;
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final formKey = GlobalKey<FormState>();
  String gen = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selected Wrong Pickup Location',
                style: TextStyle(color: Colors.black),
              ),
              Radio(
                value: "M",
                groupValue: gen,
                onChanged: (value) {
                  setState(() {
                    error = value.toString();
                    gen = value.toString();
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.black),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selected Different Service/Vehicle',
                style: TextStyle(color: Colors.black),
              ),
              Radio(
                value: "F",
                groupValue: gen,
                onChanged: (value) {
                  setState(() {
                    error = value.toString();
                    gen = value.toString();
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.black),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selected Wrong Material Kind',
                style: TextStyle(color: Colors.black),
              ),
              Radio(
                value: "O",
                groupValue: gen,
                onChanged: (value) {
                  setState(() {
                    error = value.toString();
                    gen = value.toString();
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.black),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booked By Mistake',
                style: TextStyle(color: Colors.black),
              ),
              Radio(
                value: "B",
                groupValue: gen,
                onChanged: (value) {
                  setState(() {
                    error = value.toString();
                    gen = value.toString();
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.black),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Taking too long to confirm the pickup',
                style: TextStyle(color: Colors.black),
              ),
              Radio(
                value: "T",
                groupValue: gen,
                onChanged: (value) {
                  setState(() {
                    error = value.toString();
                    gen = value.toString();
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
