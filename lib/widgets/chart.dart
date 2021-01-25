import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSpentOnDay = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        var transaction = recentTransactions[i];
        if (transaction.date.year == weekDay.year &&
            transaction.date.month == weekDay.month &&
            transaction.date.day == weekDay.day) {
          totalSpentOnDay += transaction.amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSpentOnDay};
    }).reversed.toList();
  }

  double get totalSpend {
    return groupedTransactions.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    // print(totalSpend);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((tr) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        tr,
                        totalSpend == 0
                            ? 0.0
                            : (tr['amount'] as double) / totalSpend),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
