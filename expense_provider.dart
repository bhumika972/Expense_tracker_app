import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'expense.dart';

class ExpenseProvider with ChangeNotifier {
  final Box<Expense> _expenseBox = Hive.box<Expense>('expenses');

  List<Expense> get expenses => _expenseBox.values.toList();

  void addExpense(Expense expense) {
    _expenseBox.add(expense);
    notifyListeners();
  }

  void editExpense(int index, Expense expense) {
    _expenseBox.putAt(index, expense);
    notifyListeners();
  }

  void deleteExpense(int index) {
    _expenseBox.deleteAt(index);
    notifyListeners();
  }
}
