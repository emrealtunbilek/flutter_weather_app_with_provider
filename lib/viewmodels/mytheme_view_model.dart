import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_with_bloc/models/my_theme.dart';

class MyThemeViewModel with ChangeNotifier {
  MyTheme _myTheme;

  MyThemeViewModel() {
    _myTheme = MyTheme(Colors.blue, ThemeData.light());
  }

  MyTheme get myTheme => _myTheme;

  set myTheme(MyTheme value) {
    _myTheme = value;
    notifyListeners();
  }

  void temaDegistir(String havaDurumuKisaltmasi) {
    MyTheme _geciciTema;

    switch (havaDurumuKisaltmasi) {
      case "sn": //karlı
      case "sl": //sulu kar
      case "h": //dolu
      case "t": //fırtına
      case "hc": //çok bulutlu
        _geciciTema =
            MyTheme(Colors.grey, ThemeData(primaryColor: Colors.blueGrey));

        break;

      case "hr": //ağır yagmurlu
      case "lr": //hafif yagmurlu
      case "s": // sağanak yagıs
        _geciciTema = MyTheme(
            Colors.indigo, ThemeData(primaryColor: Colors.indigoAccent));
        break;

      case "lc": //az bulutlu
      case "c": //açık güneşli hava
        _geciciTema = MyTheme(
            Colors.yellow, ThemeData(primaryColor: Colors.orangeAccent));
        break;
    }

    myTheme = _geciciTema;
  }
}
