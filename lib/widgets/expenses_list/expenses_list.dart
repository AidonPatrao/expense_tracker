import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/widgets/expenses_list/expensesItem_card.dart';
import '../../models/expense_model.dart';


class expenseList extends StatelessWidget {
  const expenseList({super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(itemCount: expenses.length,itemBuilder: (context, index) {
       return Dismissible(key:ValueKey(expenses[index]) ,
       background: Container(color: Theme.of(context).colorScheme.error,
           margin: Theme.of(context).cardTheme.margin, child: Icon(Icons.delete_sweep_rounded)),
       onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
       },
       child: expensesCard(expenses: expenses[index])) ;
      },);

  }
}