import 'dart:async';

import 'package:courier_delivery/data/userData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loadingScreenController {
  UserData u = UserData();

  int priceCalculator() {
    double startLat =31.344259;
    double startLong = 75.575852;
    print(startLat);

    double endLat = 31.335791;
    double endLong = 75.500304;
    double distance =
    Geolocator.distanceBetween(startLat, startLong, endLat, endLong)/1000;
    // String vehicle = retrieveSelectedCard();
    Future<String> vehicle = retrieveSelectedCard();

    // switch (vehicle) {
    //   case 'Mini-Truck':
    //     return Image.asset('assets/images/truck-small.png', width: 50);
    //   case 'Truck':
    //     return Image.asset('assets/images/truck-big.png', width: 70);
    //   case 'Single-Tanker':
    //     return Image.asset('assets/images/tanker-small.png', width: 50);
    //   case 'Double-Tanker':
    //     return Image.asset('assets/images/tanker-big.png', width: 70);
    //   default:
    //     return Image.asset('assets/images/truck-small.png', width: 50);
    // }

    int round_distance = distance.round();
    int truck = 500;
    int total_price;
    if(round_distance>5){
      return total_price = truck + (round_distance - 5) * 100;
    }else{
     return 500;
    }


  }
  Future<String> retrieveSelectedCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String vehicle =  prefs.getString('selectedCardItemName') ?? '';
    print("Vehicle selected: ${vehicle}");
    return vehicle;
  }
}
