import 'package:flutter/material.dart';
import 'package:learning/widgets/expenses.dart';
import'package:uuid/uuid.dart';     //checkout pub.dev for initialization/utility methods
import 'package:intl/intl.dart';

const uuid = Uuid();

final formattedDate = DateFormat.yMMMMEEEEd();



enum Category {leisure,work,travel,food}   //enum used to reduce the size constraint, if type = String, then the number of values that could hold is true for
                                                                                       // larger, ie:more prone to errors


       const CategoryIcons = {      //a map created implying each category to its icon to make it conditional
           Category.leisure : Icons.free_breakfast_outlined,
         Category.work : Icons.work,
         Category.travel : Icons.flight_takeoff,
         Category.food: Icons.fastfood ,
       };

class Expense {
   Expense({
     required this.name, required this.date, required this.price,required this.category
   }) : id = uuid.v4();  //initializer list
  final String id;
  final String name;
  final DateTime date;
  final double price;

  final Category category;

  String get dateFormated {
    return formattedDate.format(date);
  }


}

class ExpenseBucket{



  const ExpenseBucket({required this.expenses,required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category) : expenses = allExpenses.where((expense) => expense.category==category).toList();

  final List<Expense> expenses;
  final Category category;

  double get totalExpenses{
    double sum=0;
    for(final expense in expenses){
        sum += expense.price;
    }

    return sum;

  }
}