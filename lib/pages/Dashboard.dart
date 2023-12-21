import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:zaboteru/providers/result_provider.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  bool isSterilization = false;
  bool isHeating = false;
  DateTime today = DateTime.now();

  Map<int, String> months = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  @override
  Widget build(BuildContext context) {
    String formattedDate = '${today.day} ${months[today.month]} ${today.year}';
    return ScreenUtilInit(
      child: Scaffold(
          body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.h),
              Text(
                'Today\n$formattedDate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 79, 79, 79),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 30.h),
              CircularPercentIndicator(
                radius: 100.w,
                lineWidth: 14.w,
                percent: 0.4,
                progressColor: Colors.blue,
                backgroundColor: const Color.fromARGB(255, 197, 205, 208),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '40%',
                  style: TextStyle(fontSize: 28.sp),
                ),
              ),
              SizedBox(height: 30.h),
              const Divider(
                color: Color.fromARGB(255, 197, 205, 208),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Adjust the padding as needed
                child: SizedBox(
                  height:
                      120, // Set a fixed height or use MediaQuery.of(context).size.height
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Days Streak\n',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0.w), // Add space between containers
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Day Goal\n${context.watch<ResultProvider>().result[0].toStringAsPrecision(3)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0.w), // Add space between containers
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Bottles to go\n${context.watch<ResultProvider>().result[1].toStringAsPrecision(3)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Enable Sterilization',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Switch(
                          value: isSterilization,
                          onChanged: (value) {
                            setState(() {
                              isSterilization = value;
                            });
                          },
                          activeColor:
                              Colors.blue, // Color when the switch is ON
                          activeTrackColor: const Color.fromARGB(255, 147, 191,
                              228), // Track color when the switch is ON
                          inactiveTrackColor: const Color.fromARGB(255, 218,
                              218, 218), // Color when the switch is OFF
                          inactiveThumbColor: const Color.fromARGB(255, 174,
                              174, 174), // Track color when the switch is OFF),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Enable Heating',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Switch(
                          value: isHeating,
                          onChanged: (value) {
                            setState(() {
                              isHeating = value;
                            });
                          },
                          activeColor:
                              Colors.blue, // Color when the switch is ON
                          activeTrackColor: const Color.fromARGB(255, 147, 191,
                              228), // Track color when the switch is ON
                          inactiveTrackColor: const Color.fromARGB(255, 218,
                              218, 218), // Color when the switch is OFF
                          inactiveThumbColor: const Color.fromARGB(255, 174,
                              174, 174), // Track color when the switch is OFF),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ]),
      )),
    );
  }
}
