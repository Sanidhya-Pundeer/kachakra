import 'package:geolocator/geolocator.dart';

class UserData {
  static int userId = 0;
  static String userAddress = "";
  static String userType = "";
  static String famSize = "";
  static String userCurrentAddress = "";
  static String currentLocation = "";
  static String memberType = "";
  static int mswDriverID = 0;
  static Position currentPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    accuracy: 0.0,
    altitude: 0.0, // Providing default value for altitude
    heading: 0.0, // Providing default value for heading
    speed: 0.0, // Providing default value for speed
    speedAccuracy: 0.0, // Providing default value for speedAccuracy
    timestamp: DateTime.now(), // Providing default value for timestamp
  );

}