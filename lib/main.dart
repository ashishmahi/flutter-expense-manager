import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/chart.dart';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/tranactions_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(fontFamily: 'Quicksand', fontSize: 16))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const title = "Expense manager";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showNewTransactionPopup(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transaction> _tranactions = [
    Transaction(
        id: 't1', title: 'New Shoes', date: DateTime.now(), amount: 65.11),
    Transaction(
        id: 't1', title: 'New Shoes', date: DateTime.now(), amount: 65.11),
    Transaction(
        id: 't1', title: 'New Shoes', date: DateTime.now(), amount: 65.11),
    Transaction(
        id: 't2', title: 'New Glasses', date: DateTime.now(), amount: 12.12)
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        date: DateTime.now(),
        amount: amount);
    setState(() {
      _tranactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(MyHomePage.title),
        actions: [
          IconButton(
            onPressed: () => showNewTransactionPopup(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(width: double.infinity, child: Chart(_tranactions)),
            TransactionList(
              _tranactions,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showNewTransactionPopup(context),
      ),
    );
  }
}
