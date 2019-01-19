import 'package:flutter/material.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DebtList extends StatefulWidget {

  DebtList(this.debtList);

  List<Debt> debtList;
  @override
  _DebtListState createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    count = widget.debtList.length;
    
    
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.euro_symbol,
                  color: _getStateColor(widget.debtList[position].totalQuantity,
                      widget.debtList[position].paidQuantity)),
              title: Text("${widget.debtList[position].name}"),
              subtitle: Text("${widget.debtList[position].description}"),
              trailing: Text("${widget.debtList[position].totalQuantity}"),
              onTap: () =>
                  debugPrint("Pressed --> ${widget.debtList[position].name}"),
            ));
      },
    );
  }

  Color _getStateColor(double total, double paid) {
    if (paid == 0) return Colors.red;
    if (total == paid) return Colors.green;
    return Colors.orange;
  }

}
