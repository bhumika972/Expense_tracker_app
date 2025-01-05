import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense.dart';
import 'expense_provider.dart';
import 'form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF6C63FF), // Vibrant purple
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Add your settings functionality
            },
          ),
        ],
      ),
      body: expenses.isEmpty
          ? Center(
        child: Text(
          'No expenses added yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      )
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return GestureDetector(
            onTap: () {
              // You can open expense details here
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                leading: Icon(
                  expense.category == 'Food'
                      ? Icons.fastfood
                      : expense.category == 'Transport'
                      ? Icons.directions_car
                      : Icons.shopping_cart,
                  size: 30,
                  color: Colors.amber.shade700, // Color based on category
                ),
                title: Text(
                  expense.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  '${expense.category} - \$${expense.amount} - ${expense.date.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FormScreen(expense: expense, index: index),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        expenseProvider.deleteExpense(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6C63FF), // Match the AppBar color
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormScreen()),
          );
        },
        elevation: 6,
        tooltip: 'Add Expense',
      ),
    );
  }
}
