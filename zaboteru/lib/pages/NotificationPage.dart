import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Dismiss keyboard if pressed anywhere out of it
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
            // Customize the IconTheme for the back button
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.notifications,
                  size: 100,
                  color: Colors.blue, // Adjust the color as needed
                ),
                SizedBox(height: 20.h),
                Text(
                  'No notifications for now!',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
