import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaboteru/services/notifications.dart';
import 'package:zaboteru/providers/result_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

dynamic tabController = tabController();

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  bool isSterilization = false;
  bool isHeating = false;
  bool isVisible = false;
  DateTime today = DateTime.now();
  double drunkAmount = 0.0;
  int streak = 0;

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

  Timer? _sterilizationTimer;
  bool isSterilizationSwitchEnabled = true;
  int sterilizationRemainingTime = 10;

  // For Notifications
  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => ScreenUtilInit(
                  designSize: const Size(360, 640),
                  child: AlertDialog(
                    title: const Text('Allow Notifications'),
                    content: const Text(
                        'Our app would like to send you notifications.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Don\'t Allow',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      TextButton(
                          onPressed: () => AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context)),
                          child: Text('Allow',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              )))
                    ],
                  ),
                ));
      }
    });
  }

  @override
  void dispose() {
    _sterilizationTimer?.cancel();
    _dataSubscription?.cancel(); // Cancel the data subscription
    super.dispose();
  }

  void _startSterilizationTimer() {
    _sterilizationTimer?.cancel();

    _sterilizationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        sterilizationRemainingTime--;
      });

      if (sterilizationRemainingTime <= 0) {
        _sterilizationTimer?.cancel();
        setState(() {
          isSterilization = false;
        });

        // Disable the switch for 5 seconds
        setState(() {
          isSterilizationSwitchEnabled = false;
        });

        notifySterilization();
        // Wait for 5 seconds before hiding the message
        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            isVisible = false;
            sterilizationRemainingTime =
                10; // Reset the timer for the next sterilization
            isSterilizationSwitchEnabled = true;
          });
        });
      }
    });
  }

  int _calculatePercentage() {
    int percent = ((drunkAmount / 1000) * 100).toInt();
    return percent;
  }

  // For Bluetooth
  late BluetoothConnection connection;
  bool get isConnected => (connection.isConnected);
  StreamSubscription<Uint8List>? _dataSubscription;

  Future<void> connect() async {
    try {
      connection = await BluetoothConnection.toAddress("00:21:07:00:07:EE");
      Fluttertoast.showToast(
        msg: 'Connected to the bluetooth device',
      );
      print('Connected to the bluetooth device');
      _dataSubscription = connection.input?.listen(
        (Uint8List data) {
          String receivedString = utf8.decode(data);
          print('Received data: $receivedString');
          // use the incoming data
          double dayGoal = context.watch<GoalProvider>().goal;
          drunkAmount = dayGoal - double.parse(receivedString);
          dayGoal -= double.parse(receivedString);
        },
        onDone: () {
          print('Bluetooth connection closed');
        },
        onError: (error) {
          print('Error reading data: $error');
        },
      );
    } catch (exception) {
      try {
        if (isConnected) {
          Fluttertoast.showToast(
            msg: 'Already connected to the device',
          );
          print('Already connected to the device');
        } else {
          Fluttertoast.showToast(
            msg: 'Cannot connect, exception occured',
          );
          print('Cannot connect, exception occured');
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Cannot connect, probably not initialized connection',
        );
        print('Cannot connect, probably not initialized connection');
      }
    }
  }

  Future<void> sendData(String data) async {
    connection.output
        .add(Uint8List.fromList(utf8.encode(data))); // Sending data
    await connection.output.allSent;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = '${today.day} ${months[today.month]} ${today.year}';
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Dismiss keyboard if pressed anywhere out of it
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
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
                      percent: _calculatePercentage() / 100,
                      progressColor: Colors.blue,
                      backgroundColor: const Color.fromARGB(255, 197, 205, 208),
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animateFromLastPercent: true,
                      center: Text(
                        context.watch<GoalProvider>().goal < 0
                            ? '0%'
                            : '${_calculatePercentage().toString()}%',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 11, 80, 136),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    const Divider(
                      color: Color.fromARGB(255, 197, 205, 208),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
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
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                child: Column(children: [
                                  Text(
                                    'Streak',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 12, 57, 93),
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    '$streak Days',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ), // Add space between containers
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                child: Column(children: [
                                  Text(
                                    'Goal',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 12, 57, 93),
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    '${context.watch<GoalProvider>().goal.toStringAsPrecision(3)}L',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ), // Add space between containers
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                child: Column(children: [
                                  Text(
                                    'Quota',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 12, 57, 93),
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    '0.00L',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Enable Sterilization',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Switch(
                                value: isSterilization,
                                onChanged: (value) {
                                  setState(() {
                                    // Allow switch change only if isSterilizationSwitchEnabled is true
                                    if (isSterilizationSwitchEnabled) {
                                      isVisible = true;
                                      isSterilization = value;
                                      if (value) {
                                        _startSterilizationTimer();
                                        sendData('1');
                                      } else {
                                        // If the switch is turned off, cancel the timer
                                        _sterilizationTimer?.cancel();
                                        sendData('0');
                                      }
                                    }
                                  });
                                },
                                activeColor: Colors.blue,
                                activeTrackColor:
                                    const Color.fromARGB(255, 147, 191, 228),
                                inactiveTrackColor:
                                    const Color.fromARGB(255, 218, 218, 218),
                                inactiveThumbColor:
                                    const Color.fromARGB(255, 174, 174, 174),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
                          child: Visibility(
                              visible: isVisible,
                              child: SizedBox(
                                height: 40.h,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0.w, right: 16.0.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          sterilizationRemainingTime > 0
                                              ? 'Time Remaining till the end of Sterilization\n$sterilizationRemainingTime seconds'
                                              : 'Done Sterilization!',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 33, 33, 34),
                                              fontSize: 13.1.sp),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Enable Heating',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Switch(
                                value: isHeating,
                                onChanged: (value) {
                                  setState(() {
                                    isHeating = value;
                                    if (value) {
                                      sendData('3');
                                    } else {
                                      sendData('2');
                                    }
                                  });
                                },
                                activeColor:
                                    Colors.blue, // Color when the switch is ON
                                activeTrackColor:
                                    const Color.fromARGB(255, 147, 191, 228),
                                inactiveTrackColor:
                                    const Color.fromARGB(255, 218, 218, 218),
                                inactiveThumbColor:
                                    const Color.fromARGB(255, 174, 174, 174),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70.h,
                        ),
                      ],
                    )
                  ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => connect(),
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: Icon(
              Icons.bluetooth,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
        ),
      ),
    );
  }
}
