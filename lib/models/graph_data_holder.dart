import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:simple_debt_manager/models/linear_amount.dart';
import 'package:simple_debt_manager/models/linear_type.dart';

class GraphDataHolder {
  double _totalAmount;
  double _totalAmountPaid;
  int _totalDebtFullyPaid;
  int _totalDebtPartialyPaid;
  int _totalDebtZeroPaid;
  double _percent;
  List<LinearAmount> _totalAmountSeriesList;
  List<LinearType> _totalTypesSeriesList;

  GraphDataHolder(){
    _totalAmount = 0.0;
    _totalAmountPaid = 0.0;
    _totalDebtFullyPaid = 0;
    _totalDebtPartialyPaid = 0;
    _totalDebtZeroPaid = 0;
    _percent = 0.000;
    _totalAmountSeriesList = List<LinearAmount>();
    _totalTypesSeriesList = List<LinearType>();
  }

  double get totalAmount => _totalAmount;
  double get totalAmountPaid => _totalAmountPaid;
  int get totalDebtFullyPaid => _totalDebtFullyPaid;
  int get totalDebtPatialyPaid => _totalDebtPartialyPaid;
  int get totalDebtZeroPaid => _totalDebtZeroPaid;
  double get percent => _percent;
  List<LinearAmount> get totalAmountSeriesList => _totalAmountSeriesList;
  List<LinearType> get totalTypesSeriesList => _totalTypesSeriesList;

  set percent(double value) => this._percent = value;

  void addTotalAmount(double value) => _totalAmount += value;
  void addTotalAmountPaid(double value) => _totalAmountPaid += value; 
  void incrementTotalFullyPaid() => _totalDebtFullyPaid++;
  void incrementTotalPartialyPaid() => _totalDebtPartialyPaid++;
  void incrementTotalZeroyPaid() => _totalDebtZeroPaid++;
  void addSerieTotalAmount(LinearAmount serie) => _totalAmountSeriesList.add(serie);
  void addSerieTotalTypes(LinearType serie) => _totalTypesSeriesList.add(serie);
  List<charts.Series<LinearAmount, String>> totalAmountSeries() {
    return [
      new charts.Series<LinearAmount, String>(
        id: 'TotalAmount',
        domainFn: (LinearAmount amount, _) => amount.type,
        measureFn: (LinearAmount amount, _) => amount.amount,
        colorFn: (LinearAmount amount, _) => getColor(amount.color),
        data: _totalAmountSeriesList,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearAmount row, _) => '${row.type}',
      )
    ];
  }

  List<charts.Series<LinearType, String>> totalTypesSeries() {
    return [
      new charts.Series<LinearType, String>(
        id: 'TotalAmount',
        domainFn: (LinearType amount, _) => amount.type,
        measureFn: (LinearType amount, _) => amount.amount,
        colorFn: (LinearType amount, _) => getColor(amount.color),
        data: _totalTypesSeriesList,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearType row, _) => '${row.type}',
      )
    ];
  }

  charts.Color getColor(Color color){
    return charts.Color(r:color.red, 
                        b: color.blue,
                        g: color.green, 
                        a:color.alpha);
  }
}



