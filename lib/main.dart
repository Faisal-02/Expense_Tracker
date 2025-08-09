import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorSchem = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 187, 177, 198),
);
void main() {
  // // if you didn't ensure the initialization, therefore will caused an erorr
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //   (fn) {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorSchem,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorSchem.onPrimaryContainer,
          foregroundColor: kColorSchem.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
            color: kColorSchem.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchem.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorSchem.onSecondaryContainer,
                fontSize: 18,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    ),
  );
}
 // );

