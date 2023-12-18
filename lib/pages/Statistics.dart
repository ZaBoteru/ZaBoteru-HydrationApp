import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  String selectedOption = 'daily';
  List<int> numbers = [1, 2, 3, 4, 5];
  int currentTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Statistics',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 24.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        // Customize the IconTheme for the back button
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
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
                        setState(() {
                          currentTab = 2;
                        });
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
