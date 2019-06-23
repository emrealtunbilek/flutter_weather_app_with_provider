import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_with_bloc/viewmodels/mytheme_view_model.dart';
import 'package:flutter_weatherapp_with_bloc/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'widget/weather_app.dart';

void main() {
  setupLocator();
  runApp(ChangeNotifierProvider(
      builder: (context) => MyThemeViewModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeViewModel>(
      builder: (context, MyThemeViewModel myThemeViewModel, child) =>
          MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            theme: myThemeViewModel.myTheme.tema,
            home: ChangeNotifierProvider<WeatherViewModel>(
                builder: (context) => locator<WeatherViewModel>(),
                child: WeatherApp()),
          ),
    );
  }
}
