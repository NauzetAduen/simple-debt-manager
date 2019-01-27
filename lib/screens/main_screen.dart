import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_appbar.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/screens/debt_list.dart';
import 'package:simple_debt_manager/screens/general_info_screen.dart';
import 'package:simple_debt_manager/screens/new_debt.dart';
import 'package:simple_debt_manager/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Debt> debtList;
  int count = 0;
  int _currentIndex = 0;
    final GlobalKey<ScaffoldState> mainKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (debtList == null) {
      debtList = List<Debt>();
      updateListView();
    }

    return Scaffold(
      key: mainKey,
      appBar: CustomAppBar(Text("Simple Debt Manager")),
      body: _getTab(_currentIndex),
      floatingActionButton: _getFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _getNavBar(),
    );
  }

  Widget _getTab(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return DebtList(debtList);
      case 1:
        return GeneralInfo(debtList);
        break;
      default:
        return DebtList(debtList);
    }
  }

  Widget _getNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (value) {
        setState(() => _currentIndex = value);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("List")),
        BottomNavigationBarItem(icon: Icon(Icons.folder), title: Text("General"))
      ],
    );
  }

  _getFAB() {
    return FloatingActionButton(
      child: Icon(Icons.add), 
      onPressed: () {
        _navigateToNewDebt();
      },
    );
  }

  void _navigateToNewDebt() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => NewDebt(scaffoldKey: mainKey,)));
    if (result != null && result == true) {
      updateListView();
    }
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
          });
        }
      });
    });
  }
}
