import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_with_bloc/data/weather_repository.dart';
import 'package:flutter_weatherapp_with_bloc/models/weather.dart';

import '../locator.dart';

enum WeatherState {
  InitialWeatherState,
  WeatherLoadingState,
  WeatherLoadedState,
  WeatherErrorState
}

class WeatherViewModel with ChangeNotifier {
  WeatherState _state;
  WeatherRepository _repository = locator<WeatherRepository>();
  Weather _getirilenWeather;

  WeatherViewModel() {
    _getirilenWeather = Weather();
    _state = WeatherState.InitialWeatherState;
  }

  Weather get getirilenWeather => _getirilenWeather;

  WeatherState get state => _state;

  set state(WeatherState value) {
    _state = value;
    notifyListeners();
  }

  Future<Weather> havaDurumunuGetir(String sehirAdi) async {
    try {
      state = WeatherState.WeatherLoadingState;
      _getirilenWeather = await _repository.getWeather(sehirAdi);
      state = WeatherState.WeatherLoadedState;
    } catch (e) {
      state = WeatherState.WeatherErrorState;
    }
    return _getirilenWeather;
  }
}
