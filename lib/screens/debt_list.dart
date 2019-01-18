import 'package:flutter/material.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DebtList extends StatefulWidget {
  @override
  _DebtListState createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Debt> debtList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (debtList == null) {
      debtList = List<Debt>();
      updateListView();
    }
    
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.euro_symbol,
                  color: _getStateColor(this.debtList[position].totalQuantity,
                      this.debtList[position].paidQuantity)),
              title: Text("${this.debtList[position].name}"),
              subtitle: Text("${this.debtList[position].description}"),
              trailing: Text("${this.debtList[position].totalQuantity}"),
              onTap: () =>
                  debugPrint("Pressed --> ${this.debtList[position].name}"),
            ));
      },
    );
  }

  Color _getStateColor(double total, double paid) {
    if (paid == 0) return Colors.red;
    if (total == paid) return Colors.green;
    return Colors.orange;
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Debt>> debtListFuture = dbHelper.getDebtList();
      debtListFuture.then((debtList) {
        if (this.mounted) {
          setState(() {
            this.debtList = debtList;
            this.count = debtList.length;
            debugPrint("debtlist updated");
          });
        }
      });
    });
  }
}
