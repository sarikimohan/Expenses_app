import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) return;

    widget.addTx(titleController.text, double.parse(amountController.text),_selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(children: [
          TextField(
            decoration: InputDecoration(labelText: 'title'),
            controller: titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'amount',
            ),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(child: Text(_selectedDate == null ? 'No Date Chosen': 'Picked date: ${DateFormat.yMd().format(_selectedDate!).toString()}',)),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),))
                ],
              )),
          Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                  onPressed: submitData, child: Text('Add Transcation')))
        ]),
      ),
    );
  }
}
