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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Add this line to hide the back arrow
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
                        Navigator.pushNamed(context, '/dashboard');
                        setState(() {
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.pushNamed(context, '/statistics');
                        setState(() {
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pie_chart,
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Statistics',
                            style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water,
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Intake',
                            style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.pushNamed(context, '/intake');
                        setState(() {
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water,
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Intake',
                            style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey,
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
                color: Color.fromARGB(255, 79, 79, 79),
                fontFamily: 'Montserrat',
                fontSize: 14,
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
                style: TextStyle(fontSize: 28, fontFamily: 'Montserrat'),
              ),
            ),
            const SizedBox(height: 45),
            const Divider(
              color: Color.fromARGB(255, 197, 205, 208),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IntrinsicHeight(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.all(6.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      'Days Streak',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.all(6.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      'Day Goal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.all(6.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      'Bottles to go',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
                          fontFamily: 'Montserrat',
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
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Enable Heating',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
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
            )
          ]),
    ));
  }
}
