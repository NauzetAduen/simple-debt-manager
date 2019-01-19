import 'package:flutter/material.dart';
import 'package:simple_debt_manager/models/debt.dart';

class GeneralInfo extends StatefulWidget {
  List<Debt> debtList;

  GeneralInfo(this.debtList);

  @override
  _GeneralInfoState createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  double totalAmount = 0.0;
  double totalAmountPaid = 0.0;
  double percent = 0.0;
  bool first = true;
  @override
  Widget build(BuildContext context) {
    if (first){
      debugPrint("Antes de getTotals: $totalAmount");
       _getTotals();
       debugPrint("Después de getTotals: $totalAmount");
      first = !first;
    }
   
    return Center(
      child: Container(child: Column(
        children: <Widget>[
          Text("Total : ${widget.debtList.length}"),
          Text("total : $totalAmount"),
          Text("Paid : $totalAmountPaid"),
          Text("Percent : $percent %"),
        ],
      )),
    );
  }

  void _getTotals() {
    for (var debt in widget.debtList) {
      debugPrint("total : ${debt.totalQuantity}");
      totalAmount += debt.totalQuantity;
      totalAmountPaid += debt.paidQuantity;
    }
    percent = totalAmountPaid/totalAmount;
  }
}
