import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDark = false;

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
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
            // Customize the IconTheme for the back button
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity.w,
                height: 60.h,
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 178, 227, 254),
                  borderRadius: BorderRadius.circular(10.0.w),
                ),
                child: Text(
                  'Change notification ringtone',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 33, 33, 34),
                    fontSize: 18.0.sp,
                  ),
                ),
              ),
              Container(
                width: double.infinity.w,
                height: 60.h,
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 178, 227, 254),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Set Bedtime',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 33, 33, 34),
                    fontSize: 18.0.sp,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Dark Theme',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        setState(() {
                          isDark = value;
                        });
                      },
                      activeColor: Colors.blue, // Color when the switch is ON
                      activeTrackColor: const Color.fromARGB(255, 147, 191,
                          228), // Track color when the switch is ON
                      inactiveTrackColor: const Color.fromARGB(
                          255, 218, 218, 218), // Color when the switch is OFF
                      inactiveThumbColor: const Color.fromARGB(255, 174, 174,
                          174), // Track color when the switch is OFF),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
