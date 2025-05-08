import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zaboteru/providers/result_provider.dart';
import 'dart:math';

class WaterIntake extends StatefulWidget {
  const WaterIntake({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaterIntakeState createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  String? selectedActivity = '';
  double weight = 0.0;
  double height = 0.0;
  int age = 0;
  int glassesOfWater = 0;
  double goal = 0.0;

  bool isMale = true;

  final List<String> activities = [
    'Sedentary',
    'lightly active',
    'Moderately active',
    'Very active',
    'Extremely active',
  ];

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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.man,
                          color: isMale
                              ? Colors.blue
                              : Colors.grey, // Use isMale for color
                          size: 26.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            isMale =
                                true; // Set isMale to true, color will update automatically
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color.fromARGB(255, 22, 22, 22)),
                      ),
                      SizedBox(
                        width: 30.0.w,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.woman_outlined,
                          color: !isMale
                              ? Colors.blue
                              : Colors.grey, // Use !isMale for color
                          size: 26.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            isMale =
                                false; // Set isMale to false, color will update automatically
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color.fromARGB(255, 22, 22, 22)),
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
                  _buildTextInput('Age', TextInputType.number, (value) {
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
                      'Glasses of Water (250ml)', TextInputType.number,
                      (value) {
                    setState(() {
                      glassesOfWater = int.tryParse(value) ?? 0;
                    });
                  }),
                  SizedBox(height: 16.0.h),
                  ElevatedButton(
                    onPressed: () {
                      goal = calculateWaterIntake(isMale, selectedActivity,
                          weight, height, age, glassesOfWater);
                      context.read<GoalProvider>().changeresult(newGoal: goal);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16.0.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(
      String label, TextInputType keyboardType, Function(String) onChanged) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: TextField(
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: TextStyle(fontSize: 16.0.sp),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 14.0.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, List<String> options, void Function(String?)? onChanged) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: DropdownButtonFormField<String>(
          value: options.isNotEmpty ? options.first : null,
          onChanged: onChanged,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: TextStyle(fontSize: 16.0.sp),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 14.0.sp),
          ),
        ),
      ),
    );
  }
}

double calculateWaterIntake(bool isMale, String? exercise, double weight,
    double height, int age, int waterGlasses) {
  // Body Surface Area
  double bsa = 0.007184 * pow(height, 0.725) * pow(weight, 0.425);
  // Basal Metabolic Rate
  double bmr = 0.0;
  // Water lost through transdermal evaporation in (ml)
  double transdermalLoss = 350;

  // Based on Harris-Benedict Equation
  if (isMale) {
    bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
  } else {
    bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
  }

  // outputs in liter
  if (exercise == 'Sedentary') {
    bmr *= 1.2;
  } else if (exercise == 'lightly active') {
    bmr *= 1.375;
  } else if (exercise == 'Moderately active') {
    bmr *= 1.55;
  } else if (exercise == 'Very active') {
    bmr *= 1.725;
  } else if (exercise == 'Extremely active') {
    bmr *= 1.9;
  }

  double totalWaterIntake =
      bsa * transdermalLoss + bmr * 0.15 + 1500 + 150 - bmr / 4;

  // double neededWater = totalWaterIntake - waterGlasses * 0.25;

  return (totalWaterIntake / 1000);
}
