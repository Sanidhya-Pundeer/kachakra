import 'package:geolocator/geolocator.dart';

class MswDriverData {
  static int userId = 0;
  static Position currentLocation = Position(
    latitude: 0.0,
    longitude: 0.0,
    accuracy: 0.0,
    altitude: 0.0, // Providing default value for altitude
    heading: 0.0, // Providing default value for heading
    speed: 0.0, // Providing default value for speed
    speedAccuracy: 0.0, // Providing default value for speedAccuracy
    timestamp: DateTime.now(), // Providing default value for timestamp
  );
  static String name = "";
  static String phoneNumber = "";
  static String vehicleNumber = "";

}