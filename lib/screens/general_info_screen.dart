import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_pie_chart.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/models/graph_data_holder.dart';
import 'package:simple_debt_manager/models/linear_amount.dart';
import 'package:simple_debt_manager/models/linear_type.dart';
import 'package:simple_debt_manager/styles/styles.dart';

class GeneralInfo extends StatefulWidget {
  final List<Debt> debtList;
  final GraphDataHolder dataHolder;

  GeneralInfo(this.debtList, this.dataHolder);

  @override
  _GeneralInfoState createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  bool first = true;
  @override
  Widget build(BuildContext context) {
    if (first) {
      first = !first;
    }
    if (widget.debtList.isEmpty) return Center(child: Text("Nothing to show, try adding debts..."),);

    return ListView(
      children: <Widget>[
        buildTitle("Amounts"),
        buildTotalPercentPie(),
        Styles.divider,
        buildTitle("Types"),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text("Total: ${widget.debtList.length}"),
          Text("Full : ${widget.dataHolder.totalDebtFullyPaid}"),
          Text("Partial : ${widget.dataHolder.totalDebtPatialyPaid}"),
          Text("Non : ${widget.dataHolder.totalDebtZeroPaid}"),
        ],
      ),
    );
  }

  Container buildTypesPie() {
    return Container(
        width: Styles.pieWidth,
        height: Styles.pideHeight,
        child: CustomPieChart(widget.dataHolder.totalTypesSeries()));
  }

  Row buildTotalPercentPie() {
    return Row(
      children: <Widget>[
        Container(
            width: Styles.pieWidth,
            height: Styles.pideHeight,
            child: CustomPieChart(widget.dataHolder.totalAmountSeries())),
        Column(children: <Widget>[
          Text(_getPercentPaid(),
              style: Styles.percentStyle),
          Text("Paid: ${widget.dataHolder.totalAmountPaid}"),
          Text("Unpaid: ${widget.dataHolder.totalAmount - widget.dataHolder.totalAmountPaid}")
        ],
        crossAxisAlignment: CrossAxisAlignment.end,)
      ],
    );
  }

 

  String _getPercentPaid() {
    if (widget.dataHolder.totalAmount == 0 || widget.dataHolder.totalAmountPaid == 0) return "0 %";
    double percent = 100 * widget.dataHolder.totalAmountPaid / widget.dataHolder.totalAmount;
    return "${percent.round().toInt()} %";
  }

  Padding buildTitle(String value) => Padding(child: Text(
        value.toUpperCase(),
        textAlign: TextAlign.center,
        style: Styles.pieTitleStyle
      ), padding: Styles.pieTitlePadding);


}
