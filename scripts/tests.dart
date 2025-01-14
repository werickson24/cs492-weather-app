import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main() async {
  String pointsUrl = "https://api.weather.gov/points/44.058,-121.31";
  Map<String, dynamic> pointsJsonData = await getJsonFromUrl(pointsUrl);

  String forecastUrl = pointsJsonData["properties"]["forecast"];
  String forecastHourlyUrl = pointsJsonData["properties"]["forecastHourly"];

  Map<String, dynamic> forecastJsonData = await getJsonFromUrl(forecastUrl);
  Map<String, dynamic> forecastHourlyJsonData =
      await getJsonFromUrl(forecastHourlyUrl);

  List<dynamic> forecastsDay = forecastJsonData["properties"]["periods"];
  List<dynamic> forecastsHourly =
      forecastHourlyJsonData["properties"]["periods"];
  processForecasts(forecastsDay);
  processForecasts(forecastsHourly);

  return;
}

Future<Map<String, dynamic>> getJsonFromUrl(String url) async {
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}

void processForecasts(List<dynamic> forecasts) {
  // TODO: pass the array of forcasts in from main
  // For loop through the forecasts and process each forecast with the
  // processForecast function below
  for (var period in forecasts) {
    processForecast(period);
  }
}

void processForecast(Map<String, dynamic> forecast) {
  // TODO: Pass a forecast entry (either hourly or bidaily), and extract
  // The proper values that will be useful. i.e. temperature, shortForecast, longForecast
  // for now, don't return anything, just assign values for each
  // i.e. String shortForcast = "";
  // Extract the necessary values from the forecast entry
  String temperature = forecast["temperature"]?.toString() ?? "N/A";
  String shortForecast = forecast["shortForecast"] ?? "N/A";
  String longForecast = forecast["detailedForecast"] ?? "N/A";

  // For now, just print the values to verify they are being extracted correctly
  print("Temperature: $temperature");
  print("Short Forecast: $shortForecast");
  print("Long Forecast: $longForecast");
}
