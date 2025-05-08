import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  String selectedOption = 'daily';
  List<int> numbers = [1, 2, 3, 4, 5];

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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                    items: <String>[
                      'daily',
                      'weekly',
                      'monthly',
                      'yearly',
                      'lifetime'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16.0.sp),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
