import 'package:flutter/material.dart';

class WaterIntake extends StatefulWidget {
  const WaterIntake({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaterIntakeState createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  String? selectedGender = '';
  double weight = 0.0;
  double height = 0.0;
  String? selectedCountry = '';
  int age = 0;
  String? selectedActivity = '';
  int glassesOfWater = 0;

  int currentTab = 2;

  final List<String> countries = [
    'Saudi Arabia',
    'United Arab Emirates',
    'Qatar',
    'Kuwait',
    'Bahrain',
    'Oman',
    'Jordan',
    'Lebanon',
    'Iraq',
    'Egypt'
    // Add more countries as needed
  ];

  final List<String> activities = [
    'Rare',
    'Occasionally',
    'Weekly',
    'Daily',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'How much you need',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 24.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Row(
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 22, 22, 22)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildCheckbox('Male', 'male'),
                      _buildCheckbox('Female', 'female'),
                    ],
                  ),
                ],
              ),
              _buildTextInput('Weight (kg)', TextInputType.number, (value) {
                setState(() {
                  weight = double.tryParse(value) ?? 0.0;
                });
              }),
              _buildTextInput('Height (cm)', TextInputType.number, (value) {
                setState(() {
                  height = double.tryParse(value) ?? 0.0;
                });
              }),
              _buildDropdown('Country', countries, (value) {
                setState(() {
                  selectedCountry = value;
                });
              }),
              _buildTextInput('Age (years)', TextInputType.number, (value) {
                setState(() {
                  age = int.tryParse(value) ?? 0;
                });
              }),
              _buildDropdown('Physical Activity', activities, (value) {
                setState(() {
                  selectedActivity = value;
                });
              }),
              _buildTextInput('Glasses of Water', TextInputType.number,
                  (value) {
                setState(() {
                  glassesOfWater = int.tryParse(value) ?? 0;
                });
              }),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission here
                  // You can access the entered values using the state variables
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        // ignore: sized_box_for_whitespace
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    MaterialButton(
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
                MaterialButton(
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
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
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
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildCheckbox(String title, String value) {
    return Row(
      children: [
        Checkbox(
          value: selectedGender == value,
          onChanged: (bool? newValue) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
        Text(title),
      ],
    );
  }

  Widget _buildTextInput(
      String label, TextInputType keyboardType, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, List<String> options, void Function(String?)? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: options.isNotEmpty ? options.first : null,
        onChanged: onChanged,
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
