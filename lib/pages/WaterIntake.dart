import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zaboteru/providers/result_provider.dart';

List<double> waterIntakeResult = [0, 0];

class WaterIntake extends StatefulWidget {
  const WaterIntake({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaterIntakeState createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  String? selectedGender = '';
  String? selectedCountry = '';
  String? selectedActivity = '';
  double weight = 0.0;
  double height = 0.0;
  int age = 0;
  int glassesOfWater = 0;

  final List<String> countries = [
    'Egypt',
    'Saudi Arabia',
    'Qatar',
    'Kuwait',
    'Bahrain',
    'Oman',
    'Jordan',
    'Lebanon',
    'Iraq',
  ];

  final List<String> activities = [
    'Rare',
    'Occasionally',
    'Weekly',
    'Daily',
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: const Color.fromARGB(255, 22, 22, 22)),
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
                _buildTextInput(
                    'Glasses of Water (250 ml)', TextInputType.number, (value) {
                  setState(() {
                    glassesOfWater = int.tryParse(value) ?? 0;
                  });
                }),
                SizedBox(height: 16.0.h),
                ElevatedButton(
                  onPressed: () {
                    waterIntakeResult = calculateWaterIntake(
                        selectedGender,
                        selectedActivity,
                        weight,
                        height,
                        selectedCountry,
                        age,
                        glassesOfWater);
                    context
                        .read<ResultProvider>()
                        .changeresult(newResult: waterIntakeResult);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
              ],
            ),
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
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
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

List<double> calculateWaterIntake(String? gender, String? exercise,
    double weight, double height, String? country, int age, int waterGlasses) {
  double baseWaterIntake = 0;
  double activityWaterIntake = 0;
  double totalWaterIntake = 0;
  double neededWater = 0;

  // in liter
  if (gender == 'male') {
    baseWaterIntake = 3.7;
  } else {
    baseWaterIntake = 2.7;
  }

  // outputs in liter
  if (exercise == 'Rare') {
    activityWaterIntake = 0.03 * weight;
  } else if (exercise == 'Occasionally') {
    activityWaterIntake = 0.04 * weight;
  } else if (exercise == 'Weekly') {
    activityWaterIntake = 0.05 * weight;
  } else if (exercise == 'Daily') {
    activityWaterIntake = 0.06 * weight;
  }

  totalWaterIntake = baseWaterIntake + activityWaterIntake;
  neededWater = totalWaterIntake - waterGlasses * 0.25;

  return [totalWaterIntake, neededWater];
}
