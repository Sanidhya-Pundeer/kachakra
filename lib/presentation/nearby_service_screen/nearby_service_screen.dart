import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/home_container_page/models/corier_service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/userData.dart';
import '../home_container_page/controller/home_container_controller.dart';
import '../home_container_page/models/home_data.dart';
import 'controller/nearby_service_controller.dart';
import 'dart:convert' hide Codec;
import 'dart:ui'; // Hiding 'Codec' from 'dart:ui'
import 'package:courier_delivery/data/pointsData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class NearbyServiceScreen extends StatefulWidget {
  const NearbyServiceScreen({Key? key}) : super(key: key);

  @override
  State<NearbyServiceScreen> createState() => _CourierServicesScreenState();
}

class _CourierServicesScreenState extends State<NearbyServiceScreen> {
  NearbyServiceController courierServicesController =
  Get.put(NearbyServiceController());
  HomeContainerController homeContainerController =
  Get.put(HomeContainerController());

  TextEditingController searchController = TextEditingController();
  bool showMarkers = true;
  Set<Marker> markers = {}; // Use Set to hold markers
  Color customTransparentColor =
  ColorConstant.highlighter.withOpacity(0.2);
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
  late BitmapDescriptor customMarkerIconElectronic;
  late BitmapDescriptor customMarkerIconTailor;
  late BitmapDescriptor customMarkerIconFurniture;
  late BitmapDescriptor customMarkerIconFootwear;
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
                  zoom: 18.0,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 20),
                  child: FloatingActionButton(
                    foregroundColor: ColorConstant.highlighter,
                    onPressed: _moveToCurrentLocation,
                    child: Icon(Icons.my_location),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor:
                  customTransparentColor, // Use your custom transparent color
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onTapArrowleft14,
                    color: Colors.black,
                  ),
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    height: getSize(45),
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (value) {
                        onSearch();
                      },
                      decoration: InputDecoration(
                        hintText: 'What are you looking for?',
                        border: InputBorder.none,
                        contentPadding: getPadding(left: 16),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (showMarkers) {
                              clearSearch(); // Call clearSearch() when clear icon is tapped
                            } else {
                              onSearch(); // Call onSearch() when search icon is tapped
                            }
                          },
                          child: showMarkers
                              ? Icon(Icons.clear)
                              : Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapArrowleft14() {
    Get.back();
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


  onTapSearch() {
    Get.toNamed(
      AppRoutes.calculatePriceScreen,
    );
  }

  onSearch() {
    String searchKeyword = searchController.text.toLowerCase();
    // if (searchKeyword == "tv repair") {
    //   newMarkers = generateMarkersFromData(HomeData.getnearbyData());
    // } else if (searchKeyword == "ac repair") {
    //   newMarkers = generateMarkersFromData(HomeData.getnearbyData02());
    // }
    // Add more conditions for different keywords if needed

    List<Marker> newMarkers = [];

    // Add markers for nearby stations
    newMarkers.addAll(generateMarkersFromData(searchKeyword));

    setState(() {
      showMarkers = true;
      markers = Set<Marker>.of(newMarkers);
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      showMarkers = false;
      // You may want to update the map state here as well, depending on how it's implemented
    });
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
    String? repairType = 'TV';

    if (searchController.text == "Petrol") {
      iconpath = 'assets/images/petrolmarker.png';
    } else if (searchController.text == "Diesel") {
      iconpath = 'assets/images/petrolmarker.png';
    } else if (searchController.text == "CNG") {
      iconpath = 'assets/images/cylinder.png';
    } else if (searchController.text == "LPG") {
      iconpath = 'assets/images/cylinder.png';
    } else {
      iconpath = 'assets/images/petrolmarker.png';
    }
    final Uint8List markerIcon = await getBytesFromAsset(iconpath, 100);
    customMarkerIcon = BitmapDescriptor.fromBytes(markerIcon);

    final Uint8List markerIconElectronic = await getBytesFromAsset('assets/images/electronic.png', 100);
    customMarkerIconElectronic = BitmapDescriptor.fromBytes(markerIconElectronic);

    final Uint8List markerIconTailor = await getBytesFromAsset('assets/images/tailor.png', 100);
    customMarkerIconTailor = BitmapDescriptor.fromBytes(markerIconTailor);

    final Uint8List markerIconFurniture = await getBytesFromAsset('assets/images/furniture.png', 100);
    customMarkerIconFurniture = BitmapDescriptor.fromBytes(markerIconFurniture);

    final Uint8List markerIconFootwear = await getBytesFromAsset('assets/images/footwear.png', 100);
    customMarkerIconFootwear = BitmapDescriptor.fromBytes(markerIconFootwear);
  }

  List<Marker> generateMarkersFromData(String searchKeyword) {
    List<CourierService> courierServices = HomeData.getnearbyDataall();
    List<Marker> filteredMarkers = [];
    RegExp regex =
    RegExp('.*${RegExp.escape(searchKeyword)}.*', caseSensitive: false);
    String? iconpath;
    if (searchController.text == "Petrol") {
      iconpath = 'assets/images/petrol.svg';
    } else if (searchController.text == "Diesel") {
      iconpath = 'assets/images/diesel.svg';
    } else if (searchController.text == "CNG") {
      iconpath = 'assets/images/cylinder.svg';
    } else if (searchController.text == "LPG") {
      iconpath = 'assets/images/cylinder.svg';
    }

    courierServices.forEach((service) {
      if (regex.hasMatch(service.subtitle ?? "") ||
          regex.hasMatch(service.rating ?? "")) {

        if (service.subtitle!.contains('electronic') || service.rating!.contains('electronic')) {
          customMarkerIcon = customMarkerIconElectronic;
        } else if (service.subtitle!.contains('tailor') || service.rating!.contains('tailor')) {
          customMarkerIcon = customMarkerIconTailor;
        } else if (service.subtitle!.contains('furniture') || service.rating!.contains('furniture')) {
          customMarkerIcon = customMarkerIconFurniture;
        } else if (service.subtitle!.contains('footwear') || service.rating!.contains('footwear')) {
          customMarkerIcon = customMarkerIconFootwear;
        }

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
                    padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 5),
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
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(
                                    //   AppRoutes.repairServiceDetailsScreen,
                                    // );
                                  },
                                  child: CustomImageView(
                                  imagePath: ImageConstant.imgShare,
                                  height: 40,
                                  width: 40,
                                )),
                                SizedBox(height: 20),
                                GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.repairServiceDetailsScreen,
                                        arguments: {
                                          'subtitle': service.subtitle,
                                          'discription': service.discription,
                                          'charges': service.charges,
                                          'rating': service.rating,
                                          'long': service.long,
                                          'lat': service.lat,
                                          // Add more data as needed
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Check Details',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            SizedBox(width: 20),
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
                                          color: Colors.white,
                                        ),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10), // Sets padding
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
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
                        SizedBox(height: 20),
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

}
