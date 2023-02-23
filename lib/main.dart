import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: '1', title: 'Shoes', amount: 200, date: DateTime.now()),
    Transaction(id: '2', title: 'Glasses', amount: 400, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    List<Transaction> result = [];
    for (var tx in _transactions) {
      if (tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))) {
        result.add(tx);
      }
    }

    return result;
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _openModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });

    // Navigator.of(ctx).pop();
  }

  List<Widget> _buildLandscapeContent(
      Widget chartsWidget, Widget transactionsWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart ? chartsWidget : transactionsWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.25,
          child: Chart(_recentTransactions)),
      txWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      centerTitle: true,
      title: const Text('My Expenses'),
      // backgroundColor: ,
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle_sharp),
          onPressed: () => _openModalSheet(context),
        )
      ],
    );

    final chartsWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: Chart(_recentTransactions));

    final transactionsWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: TransactionList(_transactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            ..._buildLandscapeContent(chartsWidget, transactionsWidget),
          if (!isLandscape)
            ..._buildPortraitContent(mediaQuery, appBar, transactionsWidget),
        ],
      ),
    );
  }
}
