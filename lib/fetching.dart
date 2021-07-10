import 'dart:math';

import 'package:bloc_example/weather.dart';

class FetchWeather {
  Future<Weather> fetchWeather(String city) {
    return Future.delayed(Duration(seconds: 2), () {
      double rondom = Random().nextDouble();
      return Weather(
        city: city,
        temp: rondom.toDouble(),
      );
    });
  }
}
