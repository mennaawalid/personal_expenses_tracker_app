import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsProvider with ChangeNotifier {
  bool _showChart = false;

  bool get showChart {
    return _showChart;
  }

  void setShowChart(value) {
    _showChart = value;
    notifyListeners();
  }

  final List<Transactions> _userTransactions = [];

  List<Transactions> get userTransactions {
    return _userTransactions;
  }

  List<Transactions> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: tx.date.day),
        ),
      );
    }).toList();
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDayDate = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDayDate.day &&
            recentTransactions[i].date.month == weekDayDate.month &&
            recentTransactions[i].date.year == weekDayDate.year) {
          totalSum += recentTransactions[i].price;
        }
      }
      final weekDay = DateFormat.E().format(weekDayDate).substring(0, 1);

      return {'day': weekDay, 'amount': totalSum};
    })
        .reversed
        .toList(); // we user reversed so that the the list ends with the today
  }

  double get totalSpending {
    return groupedTransactions.fold(
      0.0,
      (sum, element) {
        return sum + (element['amount'] as double);
      },
    );
  }

  void addNewTransaction(String txTitle, double amount, DateTime date) {
    final newTx = Transactions(
        date: date,
        id: DateTime.now().toString(),
        title: txTitle,
        price: amount);

    _userTransactions.add(newTx);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _userTransactions.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
