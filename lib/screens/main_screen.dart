import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_appbar.dart';
import 'package:simple_debt_manager/screens/debt_list.dart';
import 'package:simple_debt_manager/screens/general_info_screen.dart';
import 'package:simple_debt_manager/screens/new_debt.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
    final GlobalKey<ScaffoldState> mainKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
        return DebtList();
      case 1:
        return GeneralInfo();
        break;
      default:
        return DebtList();
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewDebt(scaffoldKey: mainKey,)));
      },
    );
  }
}
