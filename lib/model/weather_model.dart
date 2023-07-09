
class WeatherModel {
  final String cityName;
  final double temperature;
  final double temperatureMin;
  final double temperatureMax;
  final String description;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'],
      temperatureMin: json['main']['temp_min'],
      temperatureMax: json['main']['temp_max'],
      description: json['weather'][0]['description'],
    );
  }
}