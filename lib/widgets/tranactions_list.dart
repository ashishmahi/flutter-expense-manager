import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

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
              return TransactionItem(
                  tranaction: _tranactions[index],
                  deleteTransaction: _deleteTransaction);
            },
          );
  }
}
