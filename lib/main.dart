import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/forecast/forecast_page.dart';

// TODO: With a partner, refactor the entire codebase (not just main.dart, every file)
// You should be looking for opportunities to make the code better
// Examples include (but are not limited to): Abstraction, Code Structure, Naming Conventions, Code Optimization, Redundant Code Removal, File names/directories
// You should be working with a partner. One person should be making changes to the code and the other should be documenting those changes in documentation/refactor.txt

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'CS492 Weather App';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ForecastPage(title: title),
    );
  }
}
