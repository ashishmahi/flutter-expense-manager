import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required Transaction tranaction,
    @required Function deleteTransaction,
  })  : _tranaction = tranaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _tranaction;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
            child: Text("₹${_tranaction.amount.toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
        title: Text(
          _tranaction.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(DateFormat.yMMMd().format(_tranaction.date),
            style: Theme.of(context).textTheme.bodyText1),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () {
                  _deleteTransaction(_tranaction.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                textColor: Colors.red,
                label: const Text('Delete'))
            : IconButton(
                onPressed: () {
                  _deleteTransaction(_tranaction.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
      ),
    );
  }
}
