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

    return ListView(
      children: <Widget>[
        buildTitle("Amounts"),
        buildTotalPercentPie(),
        Divider(color: Colors.redAccent),
        buildTitle("CACA"),
        buildOtroPie(),
        Text("Total Debts : ${widget.debtList.length}"),
        Text("Total Fully PAid Debts : ${dataHolder.totalDebtFullyPaid}"),
        Text(
            "Total Partialy PAid Debts : ${dataHolder.totalDebtPatialyPaid}"),
        Text("Total Zero PAid Debts : ${dataHolder.totalDebtZeroPaid}"),
        Text("total : ${dataHolder.totalAmount}"),
        Text("Paid : ${dataHolder.totalAmountPaid}"),
      ],
    );
  }

  Container buildOtroPie(){
    return Container(
      width: 300,
      height: 300,
      child: CustomPieChart(dataHolder.totalTypesSeries()),
     );
  }

  Row buildTotalPercentPie() {
    return Row(
          children: <Widget>[
              Container(
                width: 350,
                height: 150,
                  child: CustomPieChart(dataHolder.totalAmountSeries())),
            Container(
              child: Text(_getPercentPaid(), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            )
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

    dataHolder.addSerieTotalAmount(LinearAmount("Paid: ${dataHolder.totalAmountPaid}",
                                    dataHolder.totalAmountPaid,
                                     Colors.pinkAccent));
    dataHolder.addSerieTotalAmount(LinearAmount("Unpaid: ${(dataHolder.totalAmount - dataHolder.totalAmountPaid)}", 
                                    dataHolder.totalAmount - dataHolder.totalAmountPaid, 
                                    Colors.blueGrey));

    dataHolder.addSerieTotalTypes(LinearType("Fully", dataHolder.totalDebtFullyPaid, Colors.orange));
    dataHolder.addSerieTotalTypes(LinearType("Partial", dataHolder.totalDebtPatialyPaid, Colors.green));
    dataHolder.addSerieTotalTypes(LinearType("Zero", dataHolder.totalDebtZeroPaid, Colors.blue));
  }

  String _getPercentPaid() {
    if (dataHolder.totalAmount == 0) return "0 %";
    double percent = 100*dataHolder.totalAmountPaid /dataHolder.totalAmount;
    return "${percent.round().toInt()} %";
  }


    Text buildTitle(String value) => Text(value.toUpperCase(), textAlign: TextAlign.center,style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),);

}
