import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalAmount;
  final double totalPercentageOfTotal;

  const ChartBar(
      {required this.label,
      required this.totalAmount,
      required this.totalPercentageOfTotal,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              // to give the text a const height so that when it gets bigger
              // it doesn't influence the spacing the aligment of the bars
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                // shrinks or grows child to force it to fit into the available space instead of letting it grow
                child: Text(
                  '\$${totalAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              width: constraints.maxHeight * 0.08,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 220, 220),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: totalPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
