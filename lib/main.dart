import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:zaboteru/pages/Dashboard.dart';
import 'package:zaboteru/pages/NotificationPage.dart';
import 'package:zaboteru/pages/Settings.dart';
import 'package:lottie/lottie.dart';
import 'package:zaboteru/pages/Statistics.dart';
import 'package:zaboteru/pages/WaterIntake.dart';

void main() {
  runApp(const ZaBoteru());
}

class ZaBoteru extends StatelessWidget {
  const ZaBoteru({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/notification': (context) => const NotiPage(),
        '/settings': (context) => const Settings(),
        '/dashboard': (context) => const Dashboard(),
        '/statistics': (context) => const Statistics(),
        '/intake': (context) => const WaterIntake(),
      },
      home: AnimatedSplashScreen(
        splash: Stack(
          fit: StackFit.expand,
          children: [
            Lottie.asset('assets/lottie/waterFill.json', fit: BoxFit.cover),
            const Center(
              child: Text(
                'ZaBoteru',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 38.0,
                ),
              ),
            ),
          ],
        ),
        nextScreen: const Dashboard(),
        duration: 3100,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        splashIconSize: 400,
      ),
    );
  }
}


/*
##############################################################
######################### TO-DO-LIST #########################
##############################################################
Mandatory:
- Backend file for the water intake goal calculation
- Based on the backend, there will be stateful text in multiple places such
  as the stats in the dashboard (not sure if there will be other pages that
  require this)
- Add the notification feature
- Add the Bluetooth feature
- Make the statistics page

Details:
- Change the last icon of it (double intake page) in the navigation bar
- BONUS: make the application responsive to landscape mode and maintainable
  on any screen size
- BONUS: edit all the style
##############################################################
###############################################################
*/