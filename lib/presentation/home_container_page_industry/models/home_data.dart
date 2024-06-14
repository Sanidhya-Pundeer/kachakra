import 'package:courier_delivery/core/app_export.dart';
import 'recently_shipped_data_model.dart';

import 'corier_service_model.dart';
import 'home_slider_model.dart';
import 'nearby_service_model.dart';
import 'nearby_kabadhiwala_model.dart';

class HomeData{
  static List<HomeSliderIndustry> getSliderData(){
    return [
      HomeSliderIndustry(ImageConstant.imgSliderChemical,"Schedule your Chemical Waste",AppRoutes.chemicalWasteScreen),
      HomeSliderIndustry(ImageConstant.imgSliderTextile,"Schedule \nTextile Waste",AppRoutes.textileWasteScreen),
      HomeSliderIndustry(ImageConstant.imgSlider2nd,"Broken Stuff? \nGet it Repaired!!",AppRoutes.nearbyServicesScreen),
      HomeSliderIndustry(ImageConstant.imgSlider3rd,"Donate/Trade your Books.",AppRoutes.buyStickerScreen),
    ];
  }

  //list of vehicles
  static List<NearbyService> getCourierData(){
    return [
      NearbyService(ImageConstant.imgtruck,"Our New Customer Center guides you through all the ","250 Kg","Wed, 22 Jun ‘23","\₹500","Becoming the first to know about Our service and new product updates, regulatory updates, service disruption notification and more!"),
      NearbyService(ImageConstant.imgtruck,"Our New Customer Center guides you through all the ","200 Kg","Wed, 23 Jun ‘23","\₹450","Becoming the first to know about Our service and new product updates, regulatory updates, service disruption notification and more!"),
      NearbyService(ImageConstant.imgtruck,"Our New Customer Center guides you through all the ","150 Kg","Wed, 22 Jun ‘23","\₹350","Becoming the first to know about Our service and new product updates, regulatory updates, service disruption notification and more!"),
      NearbyService(ImageConstant.imgtruck,"Our New Customer Center guides you through all the ","100 Kg","Wed, 23 Jun ‘23","\₹480","Becoming the first to know about Our service and new product updates, regulatory updates, service disruption notification and more!"),
    ];
  }

  //list of services
  static List<CourierService> getnearbyData(){
    return [
      CourierService(ImageConstant.imgTVrepair,"Raju Engineer ","250 Kg",28.3841047, 77.2747222,"9780377856","201 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"Sharma TV Repair ","200 Kg",28.3786826, 77.2748983,"7696277856","185 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"MD Repair ","150 Kg",28.3821374, 77.2760356,"9988766856","211 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"RK Electrical ","100 Kg",28.3831047, 77.2787222,"9465050253","251 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"Kumar Electronics ","100 Kg",28.3731047, 77.2787222,"9465050253","190 gandhi nagar, industrial township"),
    ];
  }

  static List<CourierService> getnearbyData02(){
    return [
      CourierService(ImageConstant.imgTVrepair,"Chopra repair ","250 Kg",28.3851037, 77.2747322,"9780377856","201 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"kapoor AC ","200 Kg",28.3786426, 77.2748993,"7696277856","185 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"AC repair ","150 Kg",28.3822374, 77.2761356,"9988766856","211 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"RK Electrical ","100 Kg",28.3831047, 77.2787222,"9465050253","251 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"Kumar Electronics ","100 Kg",28.3731047, 77.2787222,"9465050253","190 gandhi nagar, industrial township"),
    ];
  }

  static List<CourierService> getnearbyDataall(){
    return [
    CourierService(ImageConstant.imgTVrepair,"Chopra Repair","electronic, ac repair, washing machine repair",31.348912,75.583732,"9780377856","201 Gandhi Nagar, Industrial Township, Jalandhar, Punjab, 144004"),
    CourierService(ImageConstant.imgTVrepair,"Kapoor AC","electronic, ac repair",31.349215,75.582651,"7696277856","185 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"AC Repair","electronic, ac repair, washing machine repair",31.350105,75.585031,"9988766856","211 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Raju Engineer","electronic, carier, tv repair",31.349850,75.582217,"9780377856","201 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Sharma TV Repair","electronic, tv repair, refrigerator",31.348556,75.581940,"7696277856","185 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"MD Repair","electronic, tv repair, radio repair",31.351284,75.583517,"9988766856","211 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"RK Electrical","electronic, tv repair, ac repair, radio repair, washing machine repair",31.349700,75.581373,"9465050253","251 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Kumar Electronics","electronic, tv repair, ac repair, radio repair, washing machine repair",31.352206,75.581861,"9465050253","190 Gandhi Nagar, Industrial Township"),

    CourierService(ImageConstant.imgTVrepair,"Kalra Footwear","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.349091,75.584109,"9780377856","201 Gandhi Nagar, Industrial Township, Jalandhar, Punjab, 144004"),
    CourierService(ImageConstant.imgTVrepair,"Kapoor Shoes","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.350229,75.583042,"7696277856","185 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Jain Traders","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.351285,75.581940,"9988766856","211 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Raj Fashion","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.350721,75.584230,"9780377856","201 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Mukesh Mochi","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.350921,75.584931,"7696277856","185 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Shoe Repair","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.352174,75.580592,"9988766856","211 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Chappal Stall","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.351232,75.581840,"9465050253","251 Gandhi Nagar, Industrial Township"),
    CourierService(ImageConstant.imgTVrepair,"Footwears","mochi, cobbler, footwear, shoes, heel, ladies chappal, belly, slippers, crocs, leather",31.352123,75.582841,"9465050253","190 Gandhi Nagar, Industrial Township"),

    CourierService(ImageConstant.imgTVrepair,"Woodworks Renovation","furniture repair, carpentry, polishing, restoration, upholstery, refurbishment",31.348725,75.582317,"9876543210","123 Model Town, Jalandhar, Punjab, 144001"),
    CourierService(ImageConstant.imgTVrepair,"Creative Furniture Solutions","furniture repair, assembly, refinishing, custom design, upholstery",31.350439,75.581904,"9871234567","456 Gandhi Nagar, Jalandhar, Punjab, 144002"),
    CourierService(ImageConstant.imgTVrepair,"Elite Furniture Restorations","furniture repair, antique restoration, varnishing, reupholstering",31.349908,75.584217,"9877890123","789 New Jawahar Nagar, Jalandhar, Punjab, 144003"),
    CourierService(ImageConstant.imgTVrepair,"Craftsman Carpentry Works","furniture repair, joinery, cabinet making, staining, woodworking",31.351092,75.584616,"9870123456","101 Central Town, Jalandhar, Punjab, 144004"),
    CourierService(ImageConstant.imgTVrepair,"Artisan Furniture Refurbishers","furniture repair, reupholstery, paint stripping, french polishing",31.348658,75.581562,"9878901234","234 Adarsh Nagar, Jalandhar, Punjab, 144005"),
    CourierService(ImageConstant.imgTVrepair,"Classic Furniture Revival","furniture repair, refinishing, custom woodworking, upholstery",31.351607,75.580840,"9876789012","567 Ranjit Nagar, Jalandhar, Punjab, 144006"),
    CourierService(ImageConstant.imgTVrepair,"Heritage Furniture Crafters","furniture repair, antique preservation, wood carving, upholstery",31.349781,75.585031,"9873456789","890 Fatehgarh Mohalla, Jalandhar, Punjab, 144007"),
    CourierService(ImageConstant.imgTVrepair,"Modern Furniture Solutions","furniture repair, contemporary design, modular furniture, upholstery",31.350992,75.582615,"9874567890","123 Guru Teg Bahadur Nagar, Jalandhar, Punjab, 144008"),
    CourierService(ImageConstant.imgTVrepair,"Royal Furniture Repairs","furniture repair, regal restoration, bespoke design, upholstery",31.349381,75.581215,"9875678901","456 Lajpat Nagar, Jalandhar, Punjab, 144009"),
    CourierService(ImageConstant.imgTVrepair,"Urban Furniture Fixers","furniture repair, urban chic designs, contemporary refurbishments",31.352058,75.584120,"9876789012","789 Patel Chowk, Jalandhar, Punjab, 144010"),

    CourierService(ImageConstant.imgTVrepair,"Stitch & Style Tailors","tailoring, alterations, dressmaking, custom designs, fittings",31.348933,75.584329,"9876543210","56 Civil Lines, Jalandhar, Punjab, 144011"),
    CourierService(ImageConstant.imgTVrepair,"Fashionable Stitches","tailoring, bridal wear, suit tailoring, custom designs, alterations",31.350236,75.583771,"9871234567","23 Green Model Town, Jalandhar, Punjab, 144012"),
    CourierService(ImageConstant.imgTVrepair,"Perfect Fit Tailoring","tailoring, alterations, menswear, womenswear, fittings",31.350864,75.584873,"9877890123","89 Guru Nanak Nagar, Jalandhar, Punjab, 144013"),
    CourierService(ImageConstant.imgTVrepair,"Sew & Sew Tailors","tailoring, alterations, clothing repair, dressmaking, fittings",31.348793,75.580982,"9870123456","34 Patel Chowk, Jalandhar, Punjab, 144014"),
    CourierService(ImageConstant.imgTVrepair,"Graceful Stitches","tailoring, alterations, formal wear, custom designs, fittings",31.349985,75.582224,"9878901234","78 Gandhi Nagar, Jalandhar, Punjab, 144015"),
    CourierService(ImageConstant.imgTVrepair,"Elegant Tailoring Services","tailoring, alterations, bespoke tailoring, custom designs, fittings",31.349631,75.584725,"9876789012","45 Model Town Extension, Jalandhar, Punjab, 144016"),
    CourierService(ImageConstant.imgTVrepair,"Classic Cuts Tailoring","tailoring, alterations, menswear, womenswear, fittings",31.350579,75.581926,"9873456789","12 Model Town, Jalandhar, Punjab, 144017"),
    CourierService(ImageConstant.imgTVrepair,"Chic Stitches","tailoring, alterations, casual wear, custom designs, fittings",31.348721,75.582926,"9873456789","12 Model Town, Jalandhar, Punjab, 144017"),
    ];
  }

  static List<CourierService> getnearbyStations(){
    return [
      CourierService(ImageConstant.imgTVrepair,"HP PETROL PUMP - GOGNA HP","Petrol, Diesel",31.3479127,75.5825284,"9780377856","201 gandhi nagar, industrial township, jalandhar, punjab, 144004"),
      CourierService(ImageConstant.imgTVrepair,"HP PETROL PUMP - JMC FILLING STATION ","Petrol, Diesel",31.3475577,75.580785,"7696277856","185 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"Bharat Petrolium ","Petrol, Diesel",31.3529567,75.5892393,"9988766856","211 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"CNG Station ","CNG",31.353107,75.5793835,"9780377856","201 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"LPG Service ","LPG",31.350931,75.5768305,"7696277856","185 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"CNG Shop ","LPG",31.352874,75.5826921,"9988766856","211 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"Fuel Station ","Diesel, Petrol, CNG",31.3524622,75.5804646,"9465050253","251 gandhi nagar, industrial township"),
      CourierService(ImageConstant.imgTVrepair,"Puneet CNG Gas","CNG",31.3528275,75.5825432,"9465050253","190 gandhi nagar, industrial township"),
    ];
  }

  //List of sweepers
  static List<NearbyService> getServiceData(){
    return [
      NearbyService(ImageConstant.imgservice4th,"Sandeep ","5.0","Sweeper","\₹500","Contact Number - 9780377856"),
      NearbyService(ImageConstant.imgservice4th,"Kumar ","5.0","Sweeper","\₹450","Contact Number - 7936589523"),
      NearbyService(ImageConstant.imgservice4th,"Ajay ","5.0","Sweeper","\₹350","Contact Number - 942562157"),
      NearbyService(ImageConstant.imgservice4th,"Vijay ","5.0","Sweeper","\₹480","Contact Number - 9465050248"),
    ];
  }

  //list of scrap collectors
  static List<NearbyKabadhiwala> getKabadhiwalaData(){
    return [
      NearbyKabadhiwala(ImageConstant.imgservice1st,"Mukesh ","5.0","Materials - Plastic, Metal","\₹500","Contact Number - 9999999999"),
      NearbyKabadhiwala(ImageConstant.imgservice1st,"Raman ","5.0","Materials - Paper, Metal","\₹450","Contact Number - 7936589523"),
      NearbyKabadhiwala(ImageConstant.imgservice1st,"Sandeep ","4.0","Materials - Scrap, Copper","\₹350","Contact Number - 942562157"),
      NearbyKabadhiwala(ImageConstant.imgservice1st,"Kuldeep ","5.0","Materials - Paper, Plastic","\₹480","Contact Number - 9465050248"),
    ];
  }
  static List<RecentlyShipped> getShippedData(){
    return [
      RecentlyShipped("PE Bag - 2 Packs","#202022194","Sat, 18 Jun 23","Completed"),
      RecentlyShipped("Replace Bin - 5 Kg","#202022194","Sat, 18 Jun 23","In Process"),
      RecentlyShipped("Scrap Pickup","#202022194","Sat, 18 Jun 23","Cancelled"),
      RecentlyShipped("C&D Waste Pickup","#202022194","Sat, 18 Jun 23","Completed"),
      RecentlyShipped("QR Code - 6 Packs","#202022194","Sat, 18 Jun 23","In Process"),
    ];
  }
}