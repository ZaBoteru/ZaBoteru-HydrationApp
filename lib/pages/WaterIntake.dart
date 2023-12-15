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
                ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCheckbox('Male', 'male'),
              _buildCheckbox('Female', 'female'),
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
              _buildTextInput('Glasses of Water', TextInputType.number, (value) {
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