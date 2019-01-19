import 'package:flutter/material.dart';
import 'package:simple_debt_manager/components/custom_appbar.dart';
import 'package:simple_debt_manager/models/debt.dart';
import 'package:simple_debt_manager/styles/styles.dart';
import 'package:simple_debt_manager/utils/validator.dart';

class DebtDetail extends StatefulWidget {
  final Debt debt;
  DebtDetail(this.debt);
  @override
  _DebtDetailState createState() => _DebtDetailState();
}

class _DebtDetailState extends State<DebtDetail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController debitorController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController paidController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(Text("${widget.debt.name}")),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: Styles.paddingForm,
                child: ListView(children: <Widget>[
                  buildProgressIndicator(0.75),
                  buildTextField(nameController, "Name", "${widget.debt.name}"),
                  buildTextField(debitorController, "Debitor", "${widget.debt.debitor}"),
                  buildTextField(descController, "Description", "${widget.debt.description}"),
                  buildQuantityField(quantityController, "Total Quantity","${widget.debt.totalQuantity}"),
                  buildQuantityField(paidController, "Paid Quantity","${widget.debt.paidQuantity}"),
                  buildButtons()

                ]))));
  }

  Widget buildProgressIndicator(value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: LinearProgressIndicator(
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        height: 30.0,
      ),
    );
  }

  Padding buildTextField(TextEditingController editController, String field, String value) {
    editController.text = value;
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

  buildQuantityField(TextEditingController editController, String field, String value) {
    editController.text = value;
    return Padding(
      padding: Styles.paddingFields,
      child: TextFormField(
          keyboardType: TextInputType.number,
          validator: Validator.validateQuantity,
          controller: editController,
          decoration: InputDecoration(
            labelText: field,
            border: Styles.borderRounded,
          )),
    );
  }

  buildButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {},
              color: Colors.red,
              child: Icon(Icons.delete),
        ),
          ),),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {},
              color: Colors.blue,
              child: Icon(Icons.update),
        ),
          ),)
    
      ],
    );
  }

}
