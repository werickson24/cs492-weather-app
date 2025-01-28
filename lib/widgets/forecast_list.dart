import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/widgets/forecast_summary_widget.dart';
import 'package:weatherapp/widgets/forecast_widget.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({
    super.key,
    required List<forecast.Forecast> forecasts,
  }) : _forecasts = forecasts;

  final List<forecast.Forecast> _forecasts;

  @override
  Widget build(BuildContext context) {
    List<ForecastSummaryWidget> summaryList = [];
    for(var summary in _forecasts){
      summaryList.add(ForecastSummaryWidget(currentForecast: summary));
    }
    return Column(
      children: summaryList
    );
  }

}