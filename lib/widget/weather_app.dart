import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_with_bloc/viewmodels/mytheme_view_model.dart';
import 'package:flutter_weatherapp_with_bloc/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_min_sicaklik.dart';
import 'sehir_sec.dart';
import 'son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  String kullanicininSectigiSehir = "Ankara";
  WeatherViewModel _weatherViewModel;

  @override
  Widget build(BuildContext context) {
    _weatherViewModel = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                kullanicininSectigiSehir = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SehirSecWidget()));
                debugPrint("Seçilen sehir: " + kullanicininSectigiSehir);
                _weatherViewModel.havaDurumunuGetir(kullanicininSectigiSehir);
              }),
        ],
      ),
      body: Center(
        child: (_weatherViewModel.state == WeatherState.WeatherLoadedState)
            ? havaDurumuGeldi(context)
            : (_weatherViewModel.state == WeatherState.WeatherLoadingState)
                ? havaDurumuGetiriliyor()
                : (_weatherViewModel.state == WeatherState.WeatherErrorState)
                    ? havaDurumuGetirHata()
                    : Text("Sehir Seçin"),
      ),
    );
  }

  ListView havaDurumuGeldi(BuildContext context) {
    var getirilenHavaDurumuKisaltmasi = Provider.of<WeatherViewModel>(context)
        .getirilenWeather
        .consolidatedWeather[0]
        .weatherStateAbbr;
    Provider.of<MyThemeViewModel>(context)
        .temaDegistir(getirilenHavaDurumuKisaltmasi);

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: LocationWidget(
            secilenSehir: kullanicininSectigiSehir,
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: SonGuncellemeWidget()), //parametresiz kullanım
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: HavaDurumuResimWidget()),
        ),
        Padding(
          padding: const EdgeInsets.all(
              16.0), //getirilen hava durumunu parametre olarak geçtik
          child: Center(
              child: MaxveMinSicaklikWidget(
            bugununDegerleri:
                _weatherViewModel.getirilenWeather.consolidatedWeather[0],
          )),
        ),
      ],
    );
  }

  havaDurumuGetiriliyor() {
    return CircularProgressIndicator();
  }

  havaDurumuGetirHata() {
    return Text("Hava durumu getirilirken hata olustu");
  }
}
