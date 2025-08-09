import 'package:expense_tracker/widgets/expenses_list/add_new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/widgets/Chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "V60",
      amount: 22.0,
      date: DateTime.now(),
      category: Category.coffee,
    ),
    Expense(
      title: "Sushi",
      amount: 142.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Spa",
      amount: 200.0,
      date: DateTime.now(),
      category: Category.lisear,
    ),
    Expense(
      title: "Work Desk",
      amount: 400.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Game",
      amount: 299,
      date: DateTime.now(),
      category: Category.lisear,
    ),
  ];

  void _openBottomSheet() {
    // This widget accept 2 context.
    // The 1st is from the class widget its self
    // The 2nd (builder) will take the context of the bottomSheet
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddNewExpense(onAddNewExpense: addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void onRemoveExpense(Expense expense) {
    final removedIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted Succusfily"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Unde",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(removedIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortraitUp =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _openBottomSheet,
            icon: Icon(Icons.plus_one_rounded),
          ),
        ],
      ),
      body: isPortraitUp
          ? Column(
              children: [
                SizedBox(height: 12),
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: ExpenseList(
                    expenseList: _registeredExpenses,
                    onDeleteExpense: onRemoveExpense,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                SizedBox(height: 12),
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: ExpenseList(
                    expenseList: _registeredExpenses,
                    onDeleteExpense: onRemoveExpense,
                  ),
                ),
              ],
            ),
    );
  }
}


// _registeredExpenses.isEmpty == true
//           ? Center(child: Text("Eneter Expense"))
//           : 