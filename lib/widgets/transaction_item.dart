import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(child: Text('\$${transaction.amount}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}
