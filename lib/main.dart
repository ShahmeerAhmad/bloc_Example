import 'package:bloc_example/cubit/weather_cubit.dart';
import 'package:bloc_example/fetching.dart';
import 'package:bloc_example/location_pag/location.dart';
import 'package:bloc_example/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider<WeatherCubit>(
        create: (context) => WeatherCubit(FetchWeather()),
        child: WetherExample(),
      ),
    );
  }
}

class WetherExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherInitial) {
          return buildTextField(context);
        } else if (state is WeatherLoading) {
          return buildCenter();
        } else if (state is WeatherLoaded) {
          return buildColumn(state.weather);
        } else {
          return Container();
        }
      }),
    );
  }

  Center buildCenter() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumn(Weather weather) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(weather.city),
        SizedBox(
          height: 50,
        ),
        Text(weather.temp.toString()),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }

  TextField buildTextField(BuildContext context) => TextField(
      onSubmitted: (val) {
        onsubmitted(context, val);
      },
      decoration: InputDecoration(hintText: "enter city"));

  void onsubmitted(BuildContext context, String value) {
    final fetchdetail = BlocProvider.of<WeatherCubit>(context);
    fetchdetail.getWeather(value);
  }
}
