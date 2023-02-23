import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var total = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          total += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': total
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return transactionValues.fold(0.0, (sum, element) {
      return sum += (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionValues
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        e['day'] as String,
                        e['amount'] as double,
                        totalSpending == 0.0
                            ? 0.0
                            : (e['amount'] as double) / totalSpending),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
