import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_pie_chart.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/models/graph_data_holder.dart';
import 'package:simple_debt_manager/models/linear_amount.dart';

class GeneralInfo extends StatefulWidget {
  final List<Debt> debtList;

  GeneralInfo(this.debtList);

  @override
  _GeneralInfoState createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  GraphDataHolder dataHolder = GraphDataHolder();
  String percentString = "0.0000";
  bool first = true;
  @override
  Widget build(BuildContext context) {
    if (first) {
      _getTotals();
      first = !first;
    }

    return Center(
      child: Container(
          child: ListView(
        children: <Widget>[
          Text("Total Debts : ${widget.debtList.length}"),
          Text("Total Fully PAid Debts : ${dataHolder.totalDebtFullyPaid}"),
          Text("Total Partialy PAid Debts : ${dataHolder.totalDebtPatialyPaid}"),
          Text("Total Zero PAid Debts : ${dataHolder.totalDebtZeroPaid}"),

          Text("total : ${dataHolder.totalAmount}"),
          Text("Paid : ${dataHolder.totalAmountPaid}"),
          Text("Percent : $percentString %"),
          Container(
            width: 400,
            height: 400,
            child : CustomPieChart(dataHolder.toSeries()))
        ],
      )),
    );
  }

  void _getTotals() {
    if (widget.debtList.isNotEmpty) {
      for (var debt in widget.debtList) {
        dataHolder.addTotalAmount(debt.totalQuantity);
        dataHolder.addTotalAmountPaid(debt.paidQuantity);

        if (debt.paidQuantity == 0) dataHolder.incrementTotalZeroyPaid();
        else if (debt.paidQuantity == debt.totalQuantity) dataHolder.incrementTotalFullyPaid();
        else dataHolder.incrementTotalPartialyPaid();

      }
      dataHolder.percent = 100 *(dataHolder.totalAmountPaid / dataHolder.totalAmount);
    }
    else dataHolder.percent = 0.0;
    
    percentString = dataHolder.percent.toStringAsFixed(2);

    dataHolder.addSerie(LinearAmount("Paid",dataHolder.totalAmountPaid));
    dataHolder.addSerie(LinearAmount("Unpaid",dataHolder.totalAmount - dataHolder.totalAmountPaid));


    
  }

}


