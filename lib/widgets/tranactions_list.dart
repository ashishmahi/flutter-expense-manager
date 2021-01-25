import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _tranactions;

  TransactionList(this._tranactions);
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: _tranactions.isEmpty
            ? Column(
                children: [
                  Text(
                    "No transactions!",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemCount: _tranactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(
                              "₹${_tranactions[index].amount.toStringAsFixed(2)}",
                              style: TextStyle(color: Colors.white,fontSize: 16)),
                        ),
                      ),
                      title: Text(
                        _tranactions[index].title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(_tranactions[index].date),
                          style: Theme.of(context).textTheme.bodyText1),
                      trailing: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ));
  }
}