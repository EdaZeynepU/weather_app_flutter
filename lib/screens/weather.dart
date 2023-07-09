import 'dart:convert';
import '../model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  final String cityName;

  const Weather({Key? key, required this.cityName}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

// Future<Map<String, dynamic>> fetchJSONData() async {
//   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
//
//   if (response.statusCode == 200) {
//     print("okkkkk");
//     print(response.body);
//     return json.decode(response.body);
//   } else {
//     print("not okkkkk");
//     throw Exception('Failed to load JSON data');
//   }
// }


class _WeatherState extends State<Weather> {
  WeatherModel? weatherData;
  String whatIsWeather="images/bglight.jpg";
  Widget icon=Placeholder();

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&appid=2183f46ee5d8c23c3290ac7cd4433027'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        weatherData = WeatherModel.fromJson(jsonData);
      });
      if(weatherData!.description.contains("cloud")){
        whatIsWeather="images/clouds.jpg";
        icon=Icon(Icons.cloud);
      }else if(weatherData!.description.contains("clear")){
        whatIsWeather="images/clearsky.jpg";
        icon=Icon(Icons.sunny);
      }
    } else {
      Navigator.pop(context,"invalid");
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Weather Page'),
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image:
            DecorationImage(image: AssetImage("${whatIsWeather}"),fit: BoxFit.cover)),
        child: Center(
          child :Container(
            height: 200,
            width: 250,
            decoration: BoxDecoration(color: Colors.white60),
            child: weatherData != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${weatherData!.cityName}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
                icon,
              ],),
                Text('Temperature: ${weatherData!.temperature}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                Text('${weatherData!.description}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ],
            )
                : CircularProgressIndicator(),
          ),
          )

      ),
    );
  }
}
