import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();
final dateFormater = DateFormat.yMd();

enum Category { work, lisear, coffee, food }

const categoryIcons = {
  Category.work: Icons.work_history_rounded,
  Category.lisear: Icons.local_play_rounded,
  Category.coffee: Icons.coffee_maker_outlined,
  Category.food: Icons.lunch_dining_rounded,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String title;
  final double amount;
  final DateTime date;
  final String id;
  final Category category;

  String get dateFormated {
    return dateFormater.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpesnes, this.category)
      : expenses = allExpesnes
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
