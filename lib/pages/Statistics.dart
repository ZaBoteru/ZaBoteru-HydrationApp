import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  String selectedOption = 'daily';

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
          ),
        ),
        // Customize the IconTheme for the back button
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final Color gradientColor = const Color(0xff23b6e6);

  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) => LineChart(LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return const FlLine(
                color: Color(0xff37434d),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  const FlSpot(0, 3),
                  const FlSpot(2.6, 2),
                  const FlSpot(4.9, 5),
                  const FlSpot(6.8, 2.5),
                  const FlSpot(8, 4),
                  const FlSpot(9.5, 3),
                  const FlSpot(11, 4),
                  const FlSpot(0, 3),
                  const FlSpot(0, 3),
                  const FlSpot(0, 3),
                  const FlSpot(0, 3),
                  const FlSpot(0, 3),
                ],
                isCurved: true,
                color: gradientColor,
                dotData: const FlDotData(show: false),
                barWidth: 5,
                belowBarData: BarAreaData(
                  show: true,
                  color: gradientColor,
                ))
          ]));
}
