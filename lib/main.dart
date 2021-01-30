import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/chart.dart';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/tranactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
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
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(fontFamily: 'Quicksand', fontSize: 16),
              button: TextStyle(color: Colors.white))),
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
    // Transaction(
    //     id: 't1', title: 'New Shoes', date: DateTime.now(), amount: 65.11),
    // Transaction(id: 't2', title: 'New Bag', date: DateTime.now(), amount: 5.11),
    // Transaction(
    //     id: 't3', title: 'New Pant', date: DateTime.now(), amount: 12.11),
    // Transaction(
    //     id: 't4', title: 'New shirt', date: DateTime.now(), amount: 43.12),
    // Transaction(
    //     id: 't5', title: 'New Item', date: DateTime.now(), amount: 67.12),
    // Transaction(
    //     id: 't6', title: 'New Gir', date: DateTime.now(), amount: 90.12),
    // Transaction(id: 't8', title: 'New Ver', date: DateTime.now(), amount: 4.12)
  ];

  bool _showChart = true;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        date: date,
        amount: amount);
    setState(() {
      _tranactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _tranactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    var appBar = AppBar(
      title: Text(MyHomePage.title),
      actions: [
        IconButton(
          onPressed: () => showNewTransactionPopup(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var transactionList = Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height) *
            0.7,
        child: TransactionList(_tranactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          appBar.preferredSize.height) *
                      0.3,
                  child: Chart(_tranactions)),
            if (!isLandscape) transactionList,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: Chart(_tranactions))
                  : transactionList
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
