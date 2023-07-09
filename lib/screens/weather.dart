import 'dart:convert';
import '../model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'loading.dart';

class Weather extends StatefulWidget {
  final String cityName;

  const Weather({Key? key, required this.cityName}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

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
    await Future.delayed(Duration(seconds: 2));
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
      }else if(weatherData!.description.contains("ain")){
        whatIsWeather="images/rain.jpg";
        icon=Icon(Icons.umbrella);
      }else if(weatherData!.description.contains("tunder")){
        whatIsWeather="images/thunderstorm.jpg";
        icon=Icon(Icons.thunderstorm_outlined);
      }else if(weatherData!.description.contains("mist")){
        whatIsWeather="images/mist.jpg";
        icon=Icon(Icons.foggy);
      }else if(weatherData!.description.contains("haze")){
        whatIsWeather="images/haze.jpg";
        icon=Icon(Icons.foggy);
      }else{
        icon = Icon(Icons.favorite_border_outlined);
      }
    } else {
      Navigator.pop(context,"invalid");
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image:
            DecorationImage(image: AssetImage("${whatIsWeather}"),fit: BoxFit.cover)),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(color: Colors.white70),
                child: weatherData != null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${weatherData!.cityName}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
                      Text('${weatherData!.temperature}°C',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    ],),
                  SizedBox(height: 15,),
                    Text('wind speed: ${weatherData!.wind}m/s',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    SizedBox(height: 5,),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('min: ${weatherData!.temperatureMin}°C',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        Text('max: ${weatherData!.temperatureMax}°C',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                      ],),

                    SizedBox(height: 15,),
                  Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    icon,
                    Text('${weatherData!.description}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    icon,
                  ],),
                  ],
                )
                    :
                Loading(),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white60),),
                  child: Text("go home",style: TextStyle(color: Colors.black,),),
              )
            ],
          ),
        )

      ),
    );
  }



}

// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Icons.sunny;
//     // Icons.snowing;
//     // Icons.cloud;
//     //
//     // return CircularProgressIndicator();
//     return Container(
//     //   child: AnimatedCrossFade(
//     //     firstChild: Icons(Icons.sunny),
//     //     secondChild: Icons.cloud,
//     //     duration: Duration(seconds: 1),
//     //     crossFadeState: CrossFadeState.showFirst,
//     //   ),
//     child: AnimatedSwitcher(
//       duration: Duration(seconds: 2),
//       child: ,
//     ),
//
//
//     )
//   }
// }

// class IconTransition extends StatefulWidget {
//   @override
//   _IconTransitionState createState() => _IconTransitionState();
// }
//
// class _IconTransitionState extends State<IconTransition> {
//   int _currentIndex = 0;
//   final List<IconData> _icons = [
//     Icons.sunny,
//     Icons.snowing,
//     Icons.cloud,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Duration(seconds: 1),
//       transitionBuilder: (Widget child, Animation<double> animation) {
//         return ScaleTransition(
//           scale: animation,
//           child: child,
//         );
//       },
//       child: Icon(
//         _icons[_currentIndex],
//         key: ValueKey(_icons[_currentIndex]),
//         size: 50,
//       ),
//     );
//   }
// }