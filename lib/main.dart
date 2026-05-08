import 'package:flutter/material.dart';
import 'package:learning/widgets/expenses.dart';
// import 'package:flutter/services.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);

final kDarkColorScheme = ColorScheme.fromSeed(brightness: Brightness.dark,
    seedColor: Colors.purple);

void main() {
  runApp(MaterialApp(
    home: Expenses(),
    darkTheme: ThemeData(colorScheme: kDarkColorScheme,
        cardTheme:
         CardThemeData().copyWith( elevation: 12,margin: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
           color: kDarkColorScheme.secondaryContainer
         ),
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: kDarkColorScheme.primary,
        foregroundColor: kDarkColorScheme.onPrimary
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(style:
      ElevatedButton.styleFrom(foregroundColor: kColorScheme.onPrimary,textStyle: TextStyle(fontStyle: FontStyle.italic)),
      ),textTheme: TextTheme(titleLarge: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)

    ),
    theme: ThemeData(colorScheme: kColorScheme,
           appBarTheme: AppBarTheme().copyWith(
             backgroundColor: kColorScheme.onSecondaryContainer,
             foregroundColor: kColorScheme.inversePrimary
           ),
        cardTheme: CardThemeData().copyWith(
          elevation: 12,margin: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          color: kColorScheme.secondaryContainer
        ), scaffoldBackgroundColor: kColorScheme.secondary,
      elevatedButtonTheme: ElevatedButtonThemeData(style:
      ElevatedButton.styleFrom(foregroundColor: kColorScheme.onPrimary,textStyle: TextStyle(fontStyle: FontStyle.italic)),
      ),
      textTheme: TextTheme(titleLarge: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
    ),
    ),
  );
}
