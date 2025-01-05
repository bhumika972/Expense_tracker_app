import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense.dart';
import 'expense_provider.dart';

class FormScreen extends StatefulWidget {
  final Expense? expense;
  final int? index;

  const FormScreen({super.key, this.expense, this.index});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  double? _amount;
  String? _category;
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null ? 'Add Expense' : 'Edit Expense'),
        backgroundColor: Colors.greenAccent, // New app bar color
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade100, Colors.deepPurple.shade50], // New gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Darker shadow
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: widget.expense?.title,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(Icons.edit), // Pencil icon
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _title = value,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.expense?.amount.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Icon(Icons.attach_money), // Dollar sign icon
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _amount = double.tryParse(value!),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter an amount' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: widget.expense?.category,
                  items: ['Food', 'Transport', 'Shopping', 'Other']
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        category == 'Food'
                            ? Icon(Icons.fastfood)
                            : category == 'Transport'
                            ? Icon(Icons.directions_car)
                            : category == 'Shopping'
                            ? Icon(Icons.shopping_cart)
                            : Icon(Icons.category),
                        SizedBox(width: 8),
                        Text(category),
                      ],
                    ),
                  ))
                      .toList(),
                  onChanged: (value) => _category = value,
                  onSaved: (value) => _category = value,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // New button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final expense = Expense(
                        title: _title!,
                        amount: _amount!,
                        category: _category!,
                        date: DateTime.now(),
                      );

                      if (widget.expense == null) {
                        expenseProvider.addExpense(expense);
                      } else {
                        expenseProvider.editExpense(widget.index!, expense);
                      }

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
