import 'dart:io';

import 'package:best_personal_expenses_tracker/widgets/adaptive_app_bar.dart';
import 'package:best_personal_expenses_tracker/providers/transactions_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/adding_transaction.dart';
import 'widgets/page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionData = Provider.of<TransactionsProvider>(context);

    void startAddingNewTransaction(BuildContext context) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddTransaction(transactionData.addNewTransaction);
        },
      );
    }

    final dynamic appBar =
        AdaptiveAppBar(startAddingNewTransaction: startAddingNewTransaction);

    final screenHeightWithoutAppBarOrStatusBar =
        MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top;

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: PageBody(
              pageHeight: screenHeightWithoutAppBarOrStatusBar,
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                startAddingNewTransaction(context);
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            appBar: appBar,
            body: PageBody(
              pageHeight: screenHeightWithoutAppBarOrStatusBar,
            ),
          );
  }
}
