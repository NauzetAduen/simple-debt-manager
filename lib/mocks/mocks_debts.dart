import 'dart:math';
import '../models/debt.dart';

class MockDebts extends Debt{
  static final List <Debt> debts = [
  
    Debt("gym", "Paco", "le debo pasta del gym", 400.0, 0),
    Debt("Móvil", "Fran", "Me compró un móvil", 250.0, 25),
    Debt("Drogas", "Roberto", "Me prestó pasta pa drogas", 100.0, 100),
    Debt("Nueva", "Fran", "Me prestó 50€ pa ropa", 50.0, 0.0)
  ];

  MockDebts(String name, String debitor, String description, double totalQuantity, double paidQuantity) : super(name, debitor, description, totalQuantity, paidQuantity);

  static Debt fetchAny(){
    return MockDebts.debts[Random().nextInt(MockDebts.debts.length)];
  }
  static List<Debt> fetchAll(){
    return MockDebts.debts;
  }
  static Debt fetchById(int id){
    return MockDebts.debts[id];
  }


}