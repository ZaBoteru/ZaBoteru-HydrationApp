import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'ZaBoteru',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 28.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 28,
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
                size: 28,
              ),
              onPressed: () {
                // Navigate to the 'settings' page here
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
        body: const Center(
          child: DashboardContent(),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          // ignore: sized_box_for_whitespace
          child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.only(right: 7.0),
                        minWidth: 40,
                        onPressed: () {
                          Navigator.pushNamed(context, '/dashbpard');
                          // setState(() {
                          //   currentTab = 0;
                          // });
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dashboard,
                              color: Colors.blue,
                              // color: currentTab == 0 ? Colors.blue: Colors.grey,
                            ),
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                  // color: currentTab == 0 ? Colors.blue : Colors.grey,
                                  ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          Navigator.pushNamed(context, '/statistics');
                          // setState(() {
                          //   currentTab = 1;
                          // });
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pie_chart,
                              color: Colors.blue,
                              // color: currentTab == 1 ? Colors.blue: Colors.grey,
                            ),
                            Text(
                              'Statistics',
                              style: TextStyle(
                                  // color: currentTab == 1 ? Colors.blue : Colors.grey,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.only(right: 29.0),
                        minWidth: 40,
                        onPressed: () {
                          Navigator.pushNamed(context, '/intake');
                          // setState(() {
                          //   currentTab = 2;
                          // });
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water,
                              color: Colors.blue,
                              // color: currentTab == 2 ? Colors.blue: Colors.grey,
                            ),
                            Text(
                              'Intake',
                              style: TextStyle(
                                  // color: currentTab == 2 ? Colors.blue : Colors.grey,
                                  ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          Navigator.pushNamed(context, '/intake');
                          // setState(() {
                          //   currentTab = 3;
                          // });
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water,
                              color: Colors.blue,
                              // color: currentTab == 3 ? Colors.blue: Colors.grey,
                            ),
                            Text(
                              'Intake',
                              style: TextStyle(
                                  // color: currentTab == 3 ? Colors.blue : Colors.grey,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  bool isSterilization = false;
  bool isHeating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Today\n16 Dec 2023',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 30),
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 14,
              percent: 0.4,
              progressColor: Colors.blue,
              backgroundColor: const Color.fromARGB(255, 197, 205, 208),
              circularStrokeCap: CircularStrokeCap.round,
              center: const Text(
                '40%',
                style: TextStyle(fontSize: 26, fontFamily: 'Montserrat'),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(
              color: Color.fromARGB(255, 197, 205, 208),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ToggleButtons(
                  isSelected: [isSterilization],
                  onPressed: (int index) {
                    setState(() {
                      isSterilization = !isSterilization;
                    });
                  },
                  color: Colors.black, // Text color when not pressed
                  selectedColor: Colors.white, // Text color when pressed
                  fillColor: isSterilization
                      ? Colors.blue
                      : const Color.fromARGB(255, 17, 98, 164),
                  borderColor: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(20.0), // Set your desired padding
                      child: Text(
                        'Enable\nSterilization',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Open Sans', fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ToggleButtons(
                  isSelected: [isHeating],
                  onPressed: (int index) {
                    setState(() {
                      isHeating = !isHeating;
                    });
                  },
                  color: Colors.black, // Text color when not pressed
                  selectedColor: Colors.white, // Text color when pressed
                  fillColor: isHeating
                      ? Colors.blue
                      : const Color.fromARGB(255, 17, 98, 164),
                  borderColor: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(20.0), // Set your desired padding
                      child: Text(
                        'Enable\nHeating',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Open Sans', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ]),
    ));
  }
}
