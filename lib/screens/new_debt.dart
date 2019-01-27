import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_appbar.dart';
import 'package:simple_debt_manager/components/custom_snackbar.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/styles/styles.dart';
import 'package:simple_debt_manager/utils/database_helper.dart';
import 'package:simple_debt_manager/utils/validator.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
                  child: FloatingActionButton(
                    onPressed: () => _validateAndSave(context),
                    child: Icon(Icons.check), ),
                      
                     // color: Theme.of(context).accentColor,
                      //textColor: Colors.black,
                      
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

     
      widget.scaffoldKey.currentState.showSnackBar(CustomSnackBar("New Debt Added").getSnack());
      //We pass an extra param to update our listview
      Navigator.pop(context, true);
    }
  }

  Padding buildTextField(TextEditingController editController, String field) {
    return Padding(
      padding: Styles.paddingFields,
      child: TextFormField(
          validator: Validator.validateString,
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
          validator: Validator.validateQuantity,
          controller: quantityController,
          decoration: InputDecoration(
            labelText: "Quantity",
            border: Styles.borderRounded,
          )),
    );
  }

}
