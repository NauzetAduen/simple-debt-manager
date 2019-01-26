import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_pie_chart.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/models/graph_data_holder.dart';
import 'package:simple_debt_manager/models/linear_amount.dart';
import 'package:simple_debt_manager/models/linear_type.dart';

class GeneralInfo extends StatefulWidget {
  final List<Debt> debtList;

  GeneralInfo(this.debtList);

  @override
  _GeneralInfoState createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  GraphDataHolder dataHolder = GraphDataHolder();
  bool first = true;
  @override
  Widget build(BuildContext context) {
    if (first) {
      _getTotals();
      first = !first;
    }
    if (widget.debtList.isEmpty) return Center(child: Text("Nothing to show, try adding debts..."),);

    return ListView(
      children: <Widget>[
        buildTitle("Amounts"),
        buildTotalPercentPie(),
        Divider(color: Colors.redAccent),
        buildTitle("CACA"),
        buildTypesInfo(),

      ],
    );
  }

  Container buildTypesInfo() {
    return Container(
      child: Row(
        children: <Widget>[
          buildTypesData(),
          buildTypesPie(),
        ],
      ),
    );
  }

  Container buildTypesData() {
    return Container(
      width: 100,
      child: Column(
        children: <Widget>[
          Text("Total: ${widget.debtList.length}"),
          Text("Full : ${dataHolder.totalDebtFullyPaid}"),
          Text("Partial : ${dataHolder.totalDebtPatialyPaid}"),
          Text("Non : ${dataHolder.totalDebtZeroPaid}"),
        ],
      ),
    );
  }

  Container buildTypesPie() {
    return Container(
        width: 300,
        height: 150,
        child: CustomPieChart(dataHolder.totalTypesSeries()));
  }

  Row buildTotalPercentPie() {
    return Row(
      children: <Widget>[
        Container(
            width: 300,
            height: 150,
            child: CustomPieChart(dataHolder.totalAmountSeries())),
        Column(children: <Widget>[
          Text(_getPercentPaid(),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          Text("Paid: ${dataHolder.totalAmountPaid}"),
          Text("Unpaid: ${dataHolder.totalAmount - dataHolder.totalAmountPaid}")
        ])
      ],
    );
  }

  void _getTotals() {
    if (widget.debtList.isNotEmpty) {
      for (var debt in widget.debtList) {
        dataHolder.addTotalAmount(debt.totalQuantity);
        dataHolder.addTotalAmountPaid(debt.paidQuantity);

        if (debt.paidQuantity == 0)
          dataHolder.incrementTotalZeroyPaid();
        else if (debt.paidQuantity == debt.totalQuantity)
          dataHolder.incrementTotalFullyPaid();
        else
          dataHolder.incrementTotalPartialyPaid();
      }
      dataHolder.percent =
          100 * (dataHolder.totalAmountPaid / dataHolder.totalAmount);
    } else
      dataHolder.percent = 0.0;

    dataHolder.addSerieTotalAmount(LinearAmount("${dataHolder.totalAmountPaid}",
        dataHolder.totalAmountPaid, Colors.pinkAccent));
    dataHolder.addSerieTotalAmount(LinearAmount(
        "${(dataHolder.totalAmount - dataHolder.totalAmountPaid)}",
        dataHolder.totalAmount - dataHolder.totalAmountPaid,
        Colors.blueGrey));

    dataHolder.addSerieTotalTypes(
        LinearType("Fully", dataHolder.totalDebtFullyPaid, Colors.orange));
    dataHolder.addSerieTotalTypes(
        LinearType("Partial", dataHolder.totalDebtPatialyPaid, Colors.green));
    dataHolder.addSerieTotalTypes(
        LinearType("Zero", dataHolder.totalDebtZeroPaid, Colors.blue));
  }

  String _getPercentPaid() {
    if (dataHolder.totalAmount == 0) return "0 %";
    print(dataHolder.totalAmountPaid);
    print(dataHolder.totalAmount);
    double percent = 100 * dataHolder.totalAmountPaid / dataHolder.totalAmount;
    return "${percent.round().toInt()} %";
  }

  Text buildTitle(String value) => Text(
        value.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      );
}
