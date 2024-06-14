import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_export.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // For iOS: (dark icons)
      statusBarIconBrightness: Brightness.dark, // For Android: (dark icons)
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        visualDensity: VisualDensity.standard,
        useMaterial3: true,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: ColorConstant.whiteA700,
            surfaceTintColor: ColorConstant.whiteA700),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                surfaceTintColor:
                MaterialStatePropertyAll(ColorConstant.whiteA700))),
        dialogTheme: DialogTheme(
            backgroundColor: ColorConstant.whiteA700,
            surfaceTintColor: ColorConstant.whiteA700),
      ),
      translations: AppLocalization(),
      locale: Get.deviceLocale, //for setting localization strings
      fallbackLocale: Locale('en', 'US'),
      title: 'courier_delivery',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
    );
  }
}
