import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? selectedDate;

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 7,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(selectedDate == null
                        ? 'No Date Chosen'
                        : 'Date: ${DateFormat.yMd().format(selectedDate as DateTime)}'),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () => widget.addTransaction(_titleController.text,
                      double.parse(_amountController.text), selectedDate),
                  child: const Text('Add Transaction'),
                  // style: ElevatedButton.styleFrom(primary: Colors.pink),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
