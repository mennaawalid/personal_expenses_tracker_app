import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart';
import 'chart.dart';

import 'transactions_list.dart';

class PageBody extends StatelessWidget {
  final double pageHeight;
  const PageBody({super.key, required this.pageHeight});

  @override
  Widget build(BuildContext context) {
    final chartProvider = Provider.of<TransactionsProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    List<Widget> inPortraitMode() {
      List<Widget> list = [
        Container(
          height: pageHeight * 0.3,
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: const Chart(),
        ),
        SizedBox(
          height: pageHeight * 0.7,
          child: const TransactionList(),
        ),
      ];
      return list;
    }

    List<Widget> inLandScapeMode() {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Show Chart',
              style: Theme.of(context).textTheme.headline6,
            ),
            Switch.adaptive(
                activeColor: Theme.of(context).colorScheme.primary,
                value: chartProvider.showChart,
                onChanged: (value) {
                  chartProvider.setShowChart(value);
                }),
          ],
        ),
        chartProvider.showChart
            ? Container(
                height: pageHeight * 0.7,
                padding: EdgeInsets.all(pageHeight * 0.05),
                width: double.infinity,
                child: const Chart(),
              )
            : SizedBox(
                height: pageHeight * 0.7,
                child: const TransactionList(),
              )
      ];
    }

    return SafeArea(
      child: ListView(
        children: <Widget>[
          if (!isLandscape) ...inPortraitMode(),
          if (isLandscape) ...inLandScapeMode(),
        ],
      ),
    );
  }
}
