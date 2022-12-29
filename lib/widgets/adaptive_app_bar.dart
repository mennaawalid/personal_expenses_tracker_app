import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function startAddingNewTransaction;
  const AdaptiveAppBar({super.key, required this.startAddingNewTransaction});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
            ),
            trailing: GestureDetector(
              onTap: () {
                startAddingNewTransaction(context);
              },
              child: const Icon(CupertinoIcons.add),
            ),
          )
        : AppBar(
            title: const Text(
              'Personal Expenss',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  startAddingNewTransaction(context);
                },
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
