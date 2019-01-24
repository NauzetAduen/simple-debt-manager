import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomPieChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside,)
        ]));
  }


}