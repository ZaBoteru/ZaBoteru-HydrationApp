import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaboteru/pages/Dashboard.dart';
import 'package:zaboteru/pages/Statistics.dart';
import 'package:zaboteru/pages/WaterIntake.dart';

class TabController extends StatefulWidget {
  const TabController({super.key});

  @override
  State<TabController> createState() => _TabControllerState();
}

class _TabControllerState extends State<TabController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Set the number of tabs
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Dismiss keyboard if pressed anywhere out of it
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              title: Text(
                'ZaBoteru',
                style: TextStyle(
                  color: Colors.white,
                  // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 26.sp,
                  ),
                  onPressed: () {
                    // Navigate to the 'notification' page here
                    Navigator.pushNamed(context, '/notification');
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 26.sp,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
              bottom: TabBar(
                tabs: [
                  CustomTab(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    text: 'Home',
                  ),
                  CustomTab(
                    icon: Icon(
                      Icons.show_chart_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    text: 'Statistics',
                  ),
                  CustomTab(
                    icon: Icon(
                      Icons.water,
                      color: Colors.white,
                      size: 20.sp,
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
          ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 5.w), // Add some space between icon and text
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
