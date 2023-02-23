import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? const Center(
              child: const Text(
              'No Transactions yet.',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) => TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction)),
    );
  }
}
