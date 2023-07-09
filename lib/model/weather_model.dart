
class WeatherModel {
  final String cityName;
  final int temperature;
  final int temperatureMin;
  final int temperatureMax;
  final double wind;
  final String description;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.description,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp']-273.15).round(),
      temperatureMin: (json['main']['temp_min']-273.15).round(),
      temperatureMax: (json['main']['temp_max']-273.15).round(),
      description: json['weather'][0]['description'],
      wind: json['wind']['speed'],
    );
  }
}