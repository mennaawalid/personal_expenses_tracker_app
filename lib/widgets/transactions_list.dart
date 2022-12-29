import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart';
import 'transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsProvider = Provider.of<TransactionsProvider>(context);

    return (transactionsProvider.userTransactions.isNotEmpty)
        ? ListView.builder(
            itemBuilder: (context, index) {
              return TransactionListItem(
                transaction: transactionsProvider.userTransactions[index],
              );
            },
            itemCount: transactionsProvider.userTransactions.length,
          )
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'There\'s no transactions yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                    height: constraints.maxHeight * 0.6,
                  ),
                ],
              );
            },
          );
  }
}
