import 'package:bloc/bloc.dart';
import 'package:bloc_example/fetching.dart';
import 'package:bloc_example/weather.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  FetchWeather fetchWeather;

  WeatherCubit(this.fetchWeather) : super(WeatherInitial());
  Future getWeather(String city) async {
    try {
      emit(WeatherLoading());
      final weather = await fetchWeather.fetchWeather(city);
      emit(WeatherLoaded(weather));
    } on Exception {
      emit(WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
