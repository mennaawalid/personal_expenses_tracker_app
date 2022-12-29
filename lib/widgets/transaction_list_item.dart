import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/transactions_provider.dart';
import 'delete_item_dialaog.dart';

class TransactionListItem extends StatelessWidget {
  final Transactions transaction;
  const TransactionListItem({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsProvider = Provider.of<TransactionsProvider>(context);

    showDialaog() {
      showDialog(
        context: context,
        builder: (ctx) {
          return DeleteItemDialoag(transaction.id);
        },
      );
    }

    return Card(
      elevation: 2,
      child: Dismissible(
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) {
              return DeleteItemDialoag(transaction.id);
            },
          );
        },
        direction: DismissDirection.endToStart,
        background: Container(
          color: Theme.of(context).colorScheme.error,
          padding: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 25,
          ),
        ),
        onDismissed: (direction) {
          transactionsProvider.deleteTransaction(transaction.id);
        },
        key: ValueKey(transaction.id),
        child: ListTile(
          title: Text(transaction.title,
              style: Theme.of(context).textTheme.headline6),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: FittedBox(
              child: Text(
                '\$${transaction.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(transaction.date),
          ),
          trailing: MediaQuery.of(context).size.width > 450
              ? TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    showDialaog();
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                  label: const Text('Delete'),
                )
              : IconButton(
                  onPressed: () {
                    showDialaog();
                  },
                  icon: Icon(Icons.delete,
                      color: Theme.of(context).colorScheme.error),
                ),
        ),
      ),
    );
  }
}
