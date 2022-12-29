import 'package:best_personal_expenses_tracker/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TransactionsProvider>(context);
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 5,
      child: Padding(
        // padding: const EdgeInsets.all(10),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...data.groupedTransactions.map((tx) {
              return Flexible(
                fit: FlexFit
                    .tight, // forces child to take available space whether it's bigger than the child or smaller
                // expanded is expactly the same as Felxible with the fit = flextfit.tight
                child: ChartBar(
                  label: tx['day'].toString(),
                  totalAmount: tx['amount'] as double,
                  totalPercentageOfTotal: data.totalSpending == 0.0
                      ? 0.0
                      : (tx['amount'] as double) / data.totalSpending,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
