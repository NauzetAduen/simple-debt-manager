import 'package:charts_flutter/flutter.dart' as charts;
import 'package:simple_debt_manager/models/linear_amount.dart';

class GraphDataHolder {
  double _totalAmount;
  double _totalAmountPaid;
  int _totalDebtFullyPaid;
  int _totalDebtPartialyPaid;
  int _totalDebtZeroPaid;
  double _percent;
  List<LinearAmount> _seriesList;

  GraphDataHolder(){
    _totalAmount = 0.0;
    _totalAmountPaid = 0.0;
    _totalDebtFullyPaid = 0;
    _totalDebtPartialyPaid = 0;
    _totalDebtZeroPaid = 0;
    _percent = 0.000;
    _seriesList = List<LinearAmount>();
  }

  double get totalAmount => _totalAmount;
  double get totalAmountPaid => _totalAmountPaid;
  int get totalDebtFullyPaid => _totalDebtFullyPaid;
  int get totalDebtPatialyPaid => _totalDebtPartialyPaid;
  int get totalDebtZeroPaid => _totalDebtZeroPaid;
  double get percent => _percent;
  List<LinearAmount> get seriesList => _seriesList;

  set percent(double value) => this._percent = value;

  void addTotalAmount(double value) => _totalAmount += value;
  void addTotalAmountPaid(double value) => _totalAmountPaid += value; 
  void incrementTotalFullyPaid() => _totalDebtFullyPaid++;
  void incrementTotalPartialyPaid() => _totalDebtPartialyPaid++;
  void incrementTotalZeroyPaid() => _totalDebtZeroPaid++;
  void addSerie(LinearAmount serie) => _seriesList.add(serie);
  List<charts.Series<LinearAmount, String>> toSeries() {

    return [
      new charts.Series<LinearAmount, String>(
        id: 'TotalAmount',
        domainFn: (LinearAmount amount, _) => amount.type,
        measureFn: (LinearAmount amount, _) => amount.amount,
        data: _seriesList,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearAmount row, _) => '${row.type}',
      )
    ];
  }
}



