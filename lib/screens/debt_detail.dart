import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_appbar.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/models/debt_action_result.dart';
import 'package:simple_debt_manager/styles/styles.dart';
import 'package:simple_debt_manager/utils/database_helper.dart';
import 'package:simple_debt_manager/utils/validator.dart';

class DebtDetail extends StatefulWidget {
  
  final Debt debt;
  DebtDetail(this.debt);
  @override
  _DebtDetailState createState() => _DebtDetailState();
}

class _DebtDetailState extends State<DebtDetail> {
  DatabaseHelper dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController debitorController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController paidController = TextEditingController();
  double percent = 0.0;

 
  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      _fillValues();
      first = false;
    }
    percent = _getPercent();
        return Scaffold(
            appBar: CustomAppBar(Text("${widget.debt.name} - ${widget.debt.id}")),
            body: Form(
                key: _formKey,
                child: Padding(
                    padding: Styles.paddingForm,
                    child: ListView(children: <Widget>[
                      buildProgressIndicator(percent),
                      buildTextField(nameController, "Name"),
                      buildTextField(debitorController, "Debitor"),
                      buildTextField(descController, "Description"),
                      buildQuantityField(),
                      buildPaidQuantityField(),
                      buildButtons()
                    ]))));
      }
    
      Widget buildProgressIndicator(value) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30.0,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 30.0,
                  child:  LinearProgressIndicator(
                    value: value,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                ),
                Center(child:_percentToText()),
              ]),
            
          ),
        );
      }
    
      Text _percentToText() => Text("${(percent*100).round().toString()} %", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),);
    
      Padding buildTextField(TextEditingController editController, String field) {
        return Padding(
            padding: Styles.paddingFields,
            child: TextFormField(
              controller: editController,
              validator: Validator.validateString,
              decoration: InputDecoration(
                labelText: field,
                border: Styles.borderRounded,
              ),
              onFieldSubmitted: (value) {
                editController.text = value;
              },
            ));
      }
    
    
      buildQuantityField() {
        return Padding(
          padding: Styles.paddingFields,
          child: TextFormField(
              keyboardType: TextInputType.number,
              validator: Validator.validateQuantity,
              controller: quantityController,
              decoration: InputDecoration(
                labelText: "Total Quantity",
                border: Styles.borderRounded,
              )),
        );
      }
    
      buildPaidQuantityField() {
        return Padding(
          padding: Styles.paddingFields,
          child: TextFormField(
              keyboardType: TextInputType.number,
              validator: _paidValidator,
              controller: paidController,
              decoration: InputDecoration(
                labelText: "Paid Quantity",
                border: Styles.borderRounded,
              )),
        );
      }
    
      buildButtons() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  
                  onPressed: () => _delete(),
                  child: Icon(Icons.delete, color: Colors.white,),
                  backgroundColor: Colors.red,
                  heroTag: "TagDelete",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  onPressed: () => _update(),
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.check, color: Colors.white,),
                  //heroTag: "TagUpdate",
                ),
              ),
          ],
        );
      }
    
      void _update() {
        if (_formKey.currentState.validate()) {
          final Debt updatedDebt = Debt.withID(
              widget.debt.id,
              nameController.text,
              debitorController.text,
              descController.text,
              double.parse(quantityController.text),
              double.parse(paidController.text));
          DebtActionResult result = DebtActionResult(
              action: 1, debtId: widget.debt.id, updateDebt: updatedDebt);
          dbHelper.updateDebt(updatedDebt);
          Navigator.pop(context, result);
        }
      }
    
      void _delete() {
        DebtActionResult result =
            DebtActionResult(action: 2, debtId: widget.debt.id, updateDebt: widget.debt);
        dbHelper.deleteDebt(widget.debt.id);
        Navigator.pop(context, result);
      }
    
      void _fillValues() {
        nameController.text = widget.debt.name;
        debitorController.text = widget.debt.debitor;
        descController.text = widget.debt.description;
        quantityController.text = widget.debt.totalQuantity.toString();
        paidController.text = widget.debt.paidQuantity.toString();
      }
    
      String _paidValidator(String value) {
        if(value.isEmpty)return "This field can not be empty";
        if(double.parse(paidController.text) > double.parse(quantityController.text)) return "This should be smaller than ${quantityController.text}";
        return null;
      }
    
      double _getPercent() {
        if (double.parse(quantityController.text) == 0 || double.parse(paidController.text) == 0) return 0;
        return double.parse(paidController.text) / double.parse(quantityController.text);
      }
}
