import 'dart:convert' hide Codec;
import 'dart:ui'; // Hiding 'Codec' from 'dart:ui'
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/pointsData.dart';
import 'package:courier_delivery/presentation/home_container_page/models/corier_service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/userData.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_subtitle_1.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../home_container_page/controller/home_container_controller.dart';
import '../home_container_page/models/home_data.dart';
import 'controller/redeem_stations_map_controller.dart';
import 'package:http/http.dart' as http;


class RedeemStationsMapScreen extends StatefulWidget {
  const RedeemStationsMapScreen({Key? key}) : super(key: key);

  @override
  State<RedeemStationsMapScreen> createState() => _CourierServicesScreenState();
}

class _CourierServicesScreenState extends State<RedeemStationsMapScreen> {
  RedeemStationsMapController courierServicesController =
      Get.put(RedeemStationsMapController());
  HomeContainerController homeContainerController =
      Get.put(HomeContainerController());

  TextEditingController searchController = TextEditingController();
  bool showMarkers = true;
  Set<Marker> markers = {}; // Use Set to hold markers
  Color customTransparentColor =
      Color.fromRGBO(255, 255, 255, 0.4627450980392157);
  Position _currentPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    accuracy: 0.0,
    altitude: 0.0, // Providing default value for altitude
    heading: 0.0, // Providing default value for heading
    speed: 0.0, // Providing default value for speed
    speedAccuracy: 0.0, // Providing default value for speedAccuracy
    timestamp: DateTime.now(), // Providing default value for timestamp
  );
  late BitmapDescriptor customMarkerIcon;
  late GoogleMapController _mapController; // Define _mapController

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.whiteA700,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
    _getCurrentLocation();
    // Update markers once the screen is loaded
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle if location services are not enabled
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Handle if location permissions are permanently denied
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle if location permissions are denied
        return;
      }
    }
    await _createCustomMarker();
    updateMarkers();
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
                onTapArrowLeft();
              },
            ),
            centerTitle: true,
            title:
                AppbarSubtitle1(text: PointsData.selectedFuel + " Stations".tr),
            styleType: Style.bgFillWhiteA700,
          ),
          body: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      UserData.currentPosition.latitude,
                      UserData.currentPosition
                          .longitude), // Initial position set to your desired location
                  zoom: 16.0,
                ),
                polylines: polylines,
                trafficEnabled: false,
                markers: markers,
                mapType: MapType.normal, // Set map type to none
                // Disable points of interest
                compassEnabled: true,
                zoomControlsEnabled: false,
                indoorViewEnabled: false,
                buildingsEnabled: true,
                mapToolbarEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  // Load custom map style
                  controller.setMapStyle(jsonEncode([
                    {
                      "stylers": [
                        {"hue": "#e0d8ff"},
                        {"saturation": 10}, // Reduce saturation to 100%
                        {
                          "lightness": 50
                        } // Adjust lightness for desired greyish tone
                      ]
                    },
                    {
                      "featureType": "poi.business",
                      "stylers": [
                        {"visibility": "off"} // Hide all businesses
                      ]
                    },
                    {
                      "featureType": "poi.business",
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "visibility": "on"
                        }, // Show geometry of important businesses

                        {"hue": "#e0d8ff"},
                        {"saturation": 10}, // Reduce saturation to 100%
                        {"lightness": 50} // Color for important businesses
                      ]
                    },
                    {
                      "featureType": "poi.business",
                      "elementType": "labels.icon",
                      "stylers": [
                        {"visibility": "off"} // Hide icons of all businesses
                      ]
                    }
                  ]));
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 80),
                  child: FloatingActionButton(
                    onPressed: _moveToCurrentLocation,
                    child: Icon(Icons.my_location),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsetsDirectional.fromSTEB(5, 7, 5, 7),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 12, 5, 12), backgroundColor: ColorConstant.highlighter,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), ),
                      elevation: 9,
                    ),
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.redeemPointsScreen,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Text('Redeem Now',
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: 18,
                        ),),
                        SizedBox(width: 10),
                        CustomImageView(
                        svgPath: 'assets/images/proceed.svg',
                        width: 30,
                      )
                    ],)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _moveToCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error: $e');
    }
    final LatLng currentLocation = LatLng(_currentPosition.latitude, _currentPosition.longitude);
    _mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
  }

  onTapArrowleft14() {
    Get.back();
  }

  void updateMarkers() {
    setState(() {
      markers = Set<Marker>.of(generateMarkers());
    });
  }

  List<Marker> generateMarkers() {
    List<Marker> newMarkers = [];

    // Add markers for nearby stations
    String searchKeyword = PointsData.selectedFuel;
    newMarkers.addAll(generateMarkersFromData(searchKeyword));

    return newMarkers;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _createCustomMarker() async {
    String? iconpath;
    if (PointsData.selectedFuel == "Petrol") {
      iconpath = 'assets/images/petrolmarker.png';
    } else if (PointsData.selectedFuel == "Diesel") {
      iconpath = 'assets/images/petrolmarker.png';
    } else if (PointsData.selectedFuel == "CNG") {
      iconpath = 'assets/images/cylinder.png';
    } else if (PointsData.selectedFuel == "LPG") {
      iconpath = 'assets/images/cylinder.png';
    }
    final Uint8List markerIcon = await getBytesFromAsset(iconpath!, 120);
    customMarkerIcon = BitmapDescriptor.fromBytes(markerIcon);
  }

  List<Marker> generateMarkersFromData(String searchKeyword) {
    List<CourierService> courierServices = HomeData.getnearbyStations();
    List<Marker> filteredMarkers = [];
    RegExp regex =
        RegExp('.*${RegExp.escape(searchKeyword)}.*', caseSensitive: false);
    String? iconpath;
    if (PointsData.selectedFuel == "Petrol") {
      iconpath = 'assets/images/petrol.svg';
    } else if (PointsData.selectedFuel == "Diesel") {
      iconpath = 'assets/images/diesel.svg';
    } else if (PointsData.selectedFuel == "CNG") {
      iconpath = 'assets/images/cylinder.svg';
    } else if (PointsData.selectedFuel == "LPG") {
      iconpath = 'assets/images/cylinder.svg';
    }

    courierServices.forEach((service) {
      if (regex.hasMatch(service.subtitle ?? "") ||
          regex.hasMatch(service.rating ?? "")) {
        filteredMarkers.add(
          Marker(
            markerId: MarkerId(service.subtitle!),
            position: LatLng(service.lat!, service.long!),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getHorizontalSize(20)),
                    topRight: Radius.circular(getHorizontalSize(20)),
                  ),
                ),
                backgroundColor: Colors.white,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getHorizontalSize(20)),
                        topRight: Radius.circular(getHorizontalSize(20)),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2, // Spread radius
                            blurRadius: 3, // Blur radius
                          offset: Offset(0, -2), // Offset in the y direction (top shadow)
                        ),
                      ],
                    ),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.subtitle!,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    service.discription!,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                    height: getVerticalSize(1),
                                    thickness: getVerticalSize(1),
                                    color: ColorConstant.gray200,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            CustomImageView(
                              svgPath: iconpath,
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _launchDirections(service.lat!, service.long!);
                                    Get.back();
                                    // Handle first button press
                                  },
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        svgPath: 'assets/images/directions.svg',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(
                                          width: 5), // Add some spacing between rows
                                      Text('Directions',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    shadowColor: ColorConstant.highlighter,
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10), // Sets padding
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _startNavigation(service.lat!, service.long!);
                                    // Handle first button press
                                  },
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: "assets/images/maplocation.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(
                                          width: 5), // Add some spacing between rows
                                      Text('Navigation',
                                        style: TextStyle(
                                          color: ColorConstant.highlighter,
                                        ),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10), // Sets padding
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle first button press
                                    _launchDialer(service.charges!);
                                  },
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        svgPath: ImageConstant.imgCall,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    shadowColor: ColorConstant.highlighter,
                                    backgroundColor: Colors.black,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10), // Sets padding
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Add some spacing between rows
                      ],
                    ),
                  );
                },
              );
            },
            icon: customMarkerIcon, // Use custom marker icon
            infoWindow: InfoWindow(
                title: service.subtitle!, snippet: service.discription!),
          ),
        );
      }
    });

    return filteredMarkers;
  }

  void _launchDirections(double destinationLat, double destinationLong) async {
    final String apiUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${UserData.currentPosition.latitude},${UserData.currentPosition.longitude}&destination=$destinationLat,$destinationLong&key=AIzaSyBv_iPnq5AaNhYzacndg_C9NgObIx-jiNU";

    final http.Response response = await http.get(Uri.parse(apiUrl));
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (responseData["status"] == "OK") {
      final List<dynamic> routes = responseData["routes"];
      final Map<String, dynamic> route = routes[0];
      final Map<String, dynamic> poly = route["overview_polyline"];
      final String points = poly["points"];

      polylineCoordinates.clear();
      final decodedCoords = decodePoly(points);
      polylineCoordinates.add(LatLng(UserData.currentPosition.latitude, UserData.currentPosition.longitude));
      polylineCoordinates.addAll(decodedCoords);

      final Polyline polyline = Polyline(
        polylineId: PolylineId('directions'),
        color: Colors.blue,
        points: polylineCoordinates,
        width: 5,
      );

      setState(() {
        polylines.add(polyline);
      });
    } else {
      // Handle error
      print("Error fetching directions");
    }
  }

  List<LatLng> decodePoly(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1E5;
      double longitude = lng / 1E5;
      points.add(LatLng(latitude, longitude));
    }
    return points;
  }

  void _launchDialer(String phoneNumber) async {
    // Remove non-numeric characters from the phone number
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _startNavigation(double lat, double long) async {
    // Remove non-numeric characters from the phone number
    final Uri url = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$long');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  onTapArrowLeft() {
    Get.back();
  }
}
