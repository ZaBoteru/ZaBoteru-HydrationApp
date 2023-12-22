import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaboteru/pages/Dashboard.dart';
import 'package:zaboteru/pages/Statistics.dart';
import 'package:zaboteru/pages/WaterIntake.dart';

class TabController extends StatelessWidget {
  const TabController({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Set the number of tabs
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
            title: Text(
              'ZaBoteru',
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
                fontSize: 26.sp,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: () {
                  // Navigate to the 'notification' page here
                  Navigator.pushNamed(context, '/notification');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: () {
                  // Navigate to the 'settings' page here
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                CustomTab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 20,
                  ),
                  text: 'Home',
                ),
                CustomTab(
                  icon: Icon(
                    Icons.show_chart_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  text: 'Statistics',
                ),
                CustomTab(
                  icon: Icon(
                    Icons.water,
                    color: Colors.white,
                    size: 20,
                  ),
                  text: 'Intake',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              DashboardContent(),
              Statistics(),
              WaterIntake(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.bluetooth,
              color: Colors.white,
              size: 28,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final Icon icon;
  final String text;

  const CustomTab({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      child: Tab(
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 5.w), // Add some space between icon and text
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
