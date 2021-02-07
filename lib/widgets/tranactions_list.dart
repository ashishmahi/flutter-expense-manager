import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _tranactions;
  final Function _deleteTransaction;

  TransactionList(this._tranactions, this._deleteTransaction);
  Widget build(BuildContext context) {
    return _tranactions.isEmpty
        ? LayoutBuilder(builder: (ctx, contrains) {
            return Column(
              children: [
                Text(
                  "No transactions!",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: contrains.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: _tranactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text(
                          "₹${_tranactions[index].amount.toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  title: Text(
                    _tranactions[index].title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(_tranactions[index].date),
                      style: Theme.of(context).textTheme.bodyText1),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          onPressed: () {
                            _deleteTransaction(_tranactions[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          textColor: Colors.red,
                          label: const Text('Delete'))
                      : IconButton(
                          onPressed: () {
                            _deleteTransaction(_tranactions[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                ),
              );
            },
          );
  }
}
