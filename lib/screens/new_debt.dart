import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_appbar.dart';
import 'package:simple_debt_manager/components/custom_snackbar.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/styles/styles.dart';
import 'package:simple_debt_manager/utils/database_helper.dart';

class NewDebt extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;

  const NewDebt({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _NewDebtState createState() => _NewDebtState();
}

class _NewDebtState extends State<NewDebt> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController debitorController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(Text("New Debt")),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: Styles.paddingForm,
            child: ListView(
              children: <Widget>[
                buildTextField(nameController, "Name"),
                buildTextField(debitorController, "Debitor"),
                buildTextField(descController, "Description"),
                buildQuantityField(),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: RaisedButton(
                      padding: EdgeInsets.all(30.0),
                      child: Text(
                        "Create",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.black,
                      onPressed: () => _validateAndSave(context)),
                )
              ],
            ),
          ),
        ));
  }

  void _validateAndSave(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final Debt debt = Debt(nameController.text, debitorController.text,
          descController.text, double.parse(quantityController.text), 0.0);
      dbHelper.insertDebt(debt);

     
      widget.scaffoldKey.currentState.showSnackBar(CustomSnackBar.snackInserted);
      Navigator.pop(context);
    }
  }

  Padding buildTextField(TextEditingController editController, String field) {
    return Padding(
      padding: Styles.paddingFields,
      child: TextFormField(
          validator: _validateString,
          controller: editController,
          decoration: InputDecoration(
            labelText: field,
            border: Styles.borderRounded,
          )),
    );
  }

  buildQuantityField() {
    return Padding(
      padding: Styles.paddingFields,
      child: TextFormField(
          keyboardType: TextInputType.number,
          validator: _validateQuantity,
          controller: quantityController,
          decoration: InputDecoration(
            labelText: "Quantity",
            border: Styles.borderRounded,
          )),
    );
  }

  String _validateString(String value) =>
      value.isEmpty ? "This field can not be empty" : null;
  String _validateQuantity(String value) {
    if (value.isEmpty) return "Add a quantity";
    if (double.parse(value) <= 0.0) return "Invalid quantity";
    return null;
  }
}
