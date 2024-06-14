
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/app_export.dart';
import '../../data/userData.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  bool showMarkers = true;
  Set<Marker> markers = {};
  String previousScreen = '';// Use Set to hold markers

  @override
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
    _getCurrentLocation();

    // Retrieve source screen from arguments
    final args = Get.arguments;
    final sourceScreen = args != null ? args['sourceScreen'] : null;
    previousScreen = sourceScreen;
    print('Navigated from: $sourceScreen');
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

    // Fetch the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      UserData.currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: ColorfulSafeArea(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Pick Location",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(UserData.currentPosition.latitude,
                      UserData.currentPosition.longitude), // Initial position set to your desired location
                  zoom: 16.0,
                ),
                onTap: _onMapTapped,
                markers: markers,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(70, 20, 70, 20),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 5, // Set background color here
                    ),
                    onPressed: () {
                      if (previousScreen == 'SchedulePickUp') {
                        Get.toNamed(
                          AppRoutes.sendPackageScreen,
                        );
                      } else if (previousScreen == 'ChemicalWaste') {
                        Get.toNamed(
                          AppRoutes.chemicalWasteScreen,
                        );
                      } else if(previousScreen == 'TextileWaste') {
                        Get.toNamed(
                          AppRoutes.textileWasteScreen,
                        );
                      }
                      },
                    child: Text('Confirm',
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapTapped(LatLng latLng) async{
    setState(() {
      markers.clear(); // Clear existing markers
      markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: latLng,
        ),
      );
      UserData.currentPosition = Position(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        accuracy: 0.0, // You may need to set appropriate values
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        timestamp: DateTime.now(),
      );
      print('----'+UserData.currentPosition.toString());
    });

    List<Placemark> placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address = "${placemark.name}, ${placemark.street}, ${placemark.administrativeArea}, ${placemark.subAdministrativeArea}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}";
      print('Address: $address');
      UserData.userCurrentAddress = address;
      // Now you can use the address as needed, such as displaying it in the UI.
    } else {
      print('No address found for the selected location.');
    }

  }
}

void main() {
  runApp(MaterialApp(
    home: SelectLocationScreen(),
  ));
}
