import './forecast.dart' as forecast;

Future<void> main() async {
  // Create a for loop that will generate forecasts arrays for each city
  List<List<double>> city_coords = [
    [44.05, -121.31],
    [41.878, -87.629],
    [40.71, -74.006],
    [25.7617, -80.1918],
    [35.0844, -106.6504]
  ];

  for (final coord in city_coords) {
    double lat = coord[0];
    double lon = coord[1];
    List<forecast.Forecast> dailyForecasts =
        await forecast.getForecastFromPoints(lat, lon);
    List<forecast.Forecast> hourlyForecasts =
        await forecast.getForecastHourlyFromPoints(lat, lon);

    print(dailyForecasts.toString());
    print(hourlyForecasts.toString());
  }
}
