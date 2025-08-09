import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenseList,
    required this.onDeleteExpense,
  });
  final void Function(Expense e) onDeleteExpense;
  final List<Expense> expenseList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //=> this means return ...
      itemCount: expenseList.length,
      itemBuilder:
          (context, index) => Dismissible(
            onDismissed: (swapDirection) {
              onDeleteExpense(expenseList[index]);
            },
            key: ValueKey(expenseList[index]),
            child: ExpenseItem(expenseList[index]),
          ),
    );
  }
}
