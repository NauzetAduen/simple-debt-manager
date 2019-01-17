import 'package:async/async.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:simple_debt_manager/models/debt.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String debtTable = "debt_table";
  String colId = "id";
  String colName = "name";
  String colDebitor = "debitor";
  String colDescription = "description";
  String colTotalQuantity = "totalQuantity";
  String colPaidQuantity = "paidQuantity";

  //dont know
  DatabaseHelper._createInstance();

  // factory keyword => used when constructor may 
  // not return a new instance. (Subclasses, already instanciated)
  factory DatabaseHelper(){
    if (_databaseHelper == null) _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  //create the bd, only used once
  void _createDb(Database database, int version) async{
    await database.execute('CREATE TABLE $debtTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT, $colDebitor TEXT, '
     '$colDescription TEXT, $colTotalQuantity REAL, $colPaidQuantity REAL)');
  }

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String databasePath = directory.path + "debts.db";
    var debtDatabase = await openDatabase(databasePath, version: 1, onCreate: _createDb);
    return debtDatabase;
  }

  Future<List<Map<String,dynamic>>> getDebtsMapList() async {
    Database database = await this.database;
    return await database.query(debtTable);
  }

  Future<int> insertDebt(Debt debt) async{
    Database db = await this.database;
    var result = await db.insert(debtTable, debt.toMap());
    return result;
  }

  Future<int> updateDebt(Debt debt) async {
    Database db = await this.database;
    return await db.update(debtTable, debt.toMap(), where: '$colId = ?', whereArgs: [debt.id]);
  }

  Future<int> deleteDebt(id) async {
    Database db = await this.database;
    return await db.delete(debtTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> getCount() async {
    Database db = await this.database;
    return Sqflite.firstIntValue(await db.query(debtTable));
  }

  Future<List<Debt>> getDebtList() async{
    List<Debt> list = List<Debt>();
    var debtMapList = await getDebtsMapList();

    for (var i = 0; i < debtMapList.length; i++) {
      list.add(Debt.fromMap(debtMapList[i]));
    }
    return list;
  }

}