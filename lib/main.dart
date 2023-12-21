import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaboteru/pages/NotificationPage.dart';
import 'package:zaboteru/pages/Settings.dart';
import 'package:lottie/lottie.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaboteru/pages/TabController.dart' as custom;
import 'package:provider/provider.dart';
import 'package:zaboteru/providers/result_provider.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const ZaBoteru());
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (BuildContext context) {
  //     return const ZaBoteru();
  //   },
  // ));
}

class ZaBoteru extends StatelessWidget {
  const ZaBoteru({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ResultProvider())
      ],
      child: ScreenUtilInit(
        builder: (_, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          routes: {
            '/notification': (context) => const NotiPage(),
            '/settings': (context) => const Settings(),
          },
          home: AnimatedSplashScreen(
            splash: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                    child: SizedBox(
                  width: double.infinity.w,
                  height: 400.h,
                  child: Lottie.asset('assets/lottie/waterFill.json',
                      fit: BoxFit.contain),
                )),
                Center(
                  child: Text(
                    'ZaBoteru',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            nextScreen: const custom.TabController(),
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
            splashIconSize: 400.sp,
          ),
        ),
        designSize: const Size(360, 640),
      ),
    );
  }
}


/*
##############################################################
######################### TO-DO-LIST #########################
##############################################################
Mandatory:
- Backend file for the water intake goal calculation [modify: enhance]
- Based on the backend, there will be stateful text in multiple places such
  as the stats in the dashboard (not sure if there will be other pages that
  require this).
- Add the notification feature [fix]
- Add the Bluetooth feature [fix]
- Make the statistics page

Consider:
- Edit the settings page to be able to add the preferences of the user.
- Print the temperature and rethink about the temperature limitation
- Local database or firebase
- Does the bottle need refilling?
- Re-think about the sensors and the buttons' events

UI Details:
- Change the last icon of it (double intake page) in the navigation bar
- BONUS: make the application responsive to landscape mode and maintainable
  on any screen size [it is a must do at least on the device we will present
  with it]
- BONUS: edit all the style
##############################################################
###############################################################
*/