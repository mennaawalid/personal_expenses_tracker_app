import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart';

class DeleteItemDialoag extends StatelessWidget {
  final String id;
  const DeleteItemDialoag(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsProvider = Provider.of<TransactionsProvider>(context);

    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Are you sure you want to delete this?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            transactionsProvider.deleteTransaction(id);
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
