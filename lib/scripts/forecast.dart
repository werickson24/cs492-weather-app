import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weatherapp/scripts/time.dart';

class Forecast{
  final String? name;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String windSpeed;
  final String windDirection;
  final String shortForecast;
  final String? detailedForecast;
  final int? precipitationProbability;
  final int? humidity;
  final num? dewpoint;
  final DateTime startTime;
  final DateTime endTime;
  final String? tempHighLow;

  Forecast({
    required this.name,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.windSpeed,
    required this.windDirection,
    required this.shortForecast,
    required this.detailedForecast,
    required this.precipitationProbability,
    required this.humidity,
    required this.dewpoint,
    required this.startTime,
    required this.endTime,
    required this.tempHighLow,
  });

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
      name: json["name"].isNotEmpty ? json["name"] : null,
      isDaytime: json["isDaytime"],
      temperature: json["temperature"],
      temperatureUnit: json["temperatureUnit"],
      windSpeed: json["windSpeed"],
      windDirection: json["windDirection"],
      shortForecast: json["shortForecast"],
      detailedForecast: json["detailedForecast"].isNotEmpty ? json["detailedForecast"]: null ,
      precipitationProbability: json["probabilityOfPrecipitation"]["value"],
      humidity: json["relativeHumidity"] != null ? json["relativeHumidity"]["value"] : null,
      dewpoint: json["dewpoint"]?["value"],
      startTime: DateTime.parse(json["startTime"]).toLocal(),
      endTime: DateTime.parse(json["endTime"]).toLocal(),
      tempHighLow: null
    );
  }

  @override
  String toString(){
    return "name: ${name ?? "None"}\n"
          "isDaytime: ${isDaytime ? "Yes" : "No"}\n"
          "temperature: $temperature\n"
          "temperatureUnit: $temperatureUnit\n"
          "windSpeed: $windSpeed\n"
          "windDirection: $windDirection\n"
          "shortForecast: $shortForecast\n"
          "detailedForecast: $detailedForecast\n"
          "precipitationProbability: ${precipitationProbability ?? "None"}\n"
          "humidity: ${humidity ?? "None"}\n"
          "dewpoint: ${dewpoint ?? "None"}\n"
          "startTime: ${startTime.toLocal()}\n"
          "endTime: ${endTime.toLocal()}\n"
          "tempHighLow: ${tempHighLow ?? "None"}";
  }

  String getIconPath(){
    const Map<String, String> forecastToIcons = {
      //Sunny
      'sunny': 'sunny',
      'clear': 'clear',
      'mostly sunny': 'mostly_sunny',
      'mostly clear': 'mostly_clear',
      'partly sunny': 'partly_clear',

      //Cloudy
      'mostly cloudy': 'mostly_cloudy',
      'partly cloudy': 'partly_cloudy',
      'cloudy': 'cloudy',

      //Rain
      'chance rain showers': 'scattered_showers',
      'rain showers likely': 'scattered_showers',
      'slight chance drizzle': 'drizzle',
      'slight chance light rain': 'drizzle',
      'rain': 'scattered_showers',
      'chance light rain': 'scattered_showers',
      'rain showers': 'scattered_showers',
      'light rain': 'scattered_showers',
      'light rain likely': 'scattered_showers',
      'slight chance rain showers': 'scattered_showers',

      //Snow
      'slight chance light snow': 'snow_showers',
      'chance light snow': 'snow_showers',
      'heavy snow likely': 'heavy_snow',
      'heavy snow': 'heavy_snow',
      'light snow likely': 'snow_showers',
      'snow': 'snow_showers',
      'light snow': 'snow_showers',
      'heavy snow and patchy blowing snow': 'blowing_snow',
      'snow likely': 'snow_showers',
      'snow and patchy blowing snow': 'blowing_snow',
      'patchy blowing snow': 'blowing_snow',
      'chance snow showers': 'snow_showers',

      //Tstorms
      'chance showers and thunderstorms': 'strong_tstorms',
      'showers and thunderstorms likely': 'strong_tstorms',
      'slight chance showers and thunderstorms': 'strong_tstorms',
      'showers and thunderstorms': 'strong_tstorms',

      //other
      'patchy blowing dust': 'dust',

      //Mix
      'rain and snow': 'wintery_mix',
      'slight chance rain and snow': 'wintery_mix',
      'rain and snow likely': 'wintery_mix',
      'chance rain and snow': 'wintery_mix',
      'slight chance snow showers': 'wintery_mix',
      'chance rain and snow showers': 'wintery_mix',

      //Ice
      'slight chance freezing drizzle': 'icy',
      'freezing drizzle likely': 'icy',
      'chance sleet': 'icy',
      'chance freezing rain': 'icy',
      'freezing rain': 'icy',
      'freezing rain likely': 'icy',
      'chance freezing drizzle': 'icy',

      //fog
      'patchy fog': 'fog',
      'areas of fog': 'fog'

    };
    // with different climates so you can eliminate more question marks
    return "assets/weather_icons/${forecastToIcons[shortForecast.toLowerCase()] ?? 'question'}.svg";
  }
}

Future<List<Forecast>> getForecastFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecast URL from the response json
  String forecastUrl = pointsJson["properties"]["forecast"];

  // make a request to the forecastJson url and decode the json data
  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  return processForecasts(forecastJson["properties"]["periods"]);
}

Future<List<Forecast>> getForecastHourlyFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecastHourly URL from the response json
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  // make a request to the forecastHourlyJson url and decode the json data
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);
  return processForecasts(forecastHourlyJson["properties"]["periods"]);
}

List<Forecast> processForecasts(List<dynamic> forecasts){
  List<Forecast> forecastObjs = [];
  for (dynamic forecast in forecasts){
    forecastObjs.add(Forecast.fromJson(forecast));
  }
  return forecastObjs;
}

Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}


Forecast getForecastDaily(Forecast forecast1, Forecast forecast2){
  String tempHighLow = getTempHighLow(forecast1.temperature, forecast2.temperature, forecast1.temperatureUnit);

  return Forecast(
    name: equalDates(DateTime.now(), forecast1.startTime) ? "Today" : forecast1.name, 
    isDaytime: forecast1.isDaytime, 
    temperature: forecast1.temperature, 
    temperatureUnit: forecast1.temperatureUnit, 
    windSpeed: forecast1.windSpeed, 
    windDirection: forecast1.windDirection, 
    shortForecast: forecast1.shortForecast, 
    detailedForecast: forecast1.detailedForecast, 
    precipitationProbability: forecast1.precipitationProbability, 
    humidity: forecast1.humidity, 
    dewpoint: forecast1.dewpoint, 
    startTime: forecast1.startTime, 
    endTime: forecast2.endTime, 
    tempHighLow: tempHighLow);

}

String getTempHighLow(int temp1, int temp2, String tempUnit){
  if (temp1 < temp2){
    return "$temp1°$tempUnit/$temp2°$tempUnit";
  }
  else {
    return "$temp2°$tempUnit/$temp1°$tempUnit";
  }

}