import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/my_theme/my_theme.dart';
import 'package:movies_app/core/route_manager.dart';
import 'package:movies_app/presentation/home_screen/home_screen.dart';

import '../presentation/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Movies App',
        theme: MyTheme.theme,
        debugShowCheckedModeBanner: false,
        routes: {
          RoutesManager.splashScreen: (_) => SplashScreen(),
          RoutesManager.homeScreen: (_) => HomeScreen(),
        },
        initialRoute: RoutesManager.splashScreen,
      ),
    );
  }
}
