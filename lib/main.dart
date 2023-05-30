import 'package:showtime_getx/presentation/bindings/app_bindings.dart';
import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ShowTime GetX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      initialBinding: AppBinding(),
      initialRoute: RouteName.home,
      getPages: AppPage.routes,
    );
  }
}
