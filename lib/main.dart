import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/widgets/forecast/forecast_tab_widget.dart';
import 'package:weatherapp/widgets/location/location_tab_widget.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/providers/theme_mode_provider.dart';

// TODOS: The TODOs are located in Assignment8-1 in canvas assignments
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ForecastProvider()),
    ChangeNotifierProvider(
        create: (context) => LocationProvider(
            Provider.of<ForecastProvider>(context, listen: false))),
    ChangeNotifierProvider(create: (context) => ThemeModeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'CS492 Weather App';

  @override
  Widget build(BuildContext context) {
    var modeProvider = Provider.of<ThemeModeProvider>(context);

    return MaterialApp(
      title: title,
      darkTheme: ThemeData.dark(),
      themeMode: modeProvider.appMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var modeProvider = Provider.of<ThemeModeProvider>(context);

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.sunny_snowing)),
              Tab(icon: Icon(Icons.edit_location_alt))
            ]),
            actions: [
              Switch(value: modeProvider.appMode, 
              onChanged: (bool value) => {modeProvider.toggleMode()})
            ],
        ),
        body: TabBarView(children: [ForecastTabWidget(), LocationTabWidget()]),
      ),
    );
  }
}
