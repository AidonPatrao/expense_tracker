import 'package:flutter/material.dart';
import 'package:learning/widgets/add_new_expense.dart';
import 'package:learning/widgets/chart/chart.dart';
import 'package:learning/widgets/expenses_list/expenses_list.dart';
import 'package:learning/models/expense_model.dart';



class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

 late final List<Expense> _totalExpense = [
   Expense(name: 'apple', date: DateTime.now(), price: 40, category: Category.food ),
   Expense(name: 'keyboard', date: DateTime.now(), price: 100, category: Category.work ),
   Expense(name: 'spain', date: DateTime.now(), price: 500, category: Category.travel ),
   Expense(name: 'badminton', date: DateTime.now(), price: 40, category: Category.leisure),
   Expense(name: 'coffee', date: DateTime.now(), price: 100, category: Category.work ),
   Expense(name: 'germany', date: DateTime.now(), price: 500, category: Category.travel ),
 ];
 void _addNewExpense(Expense expense ) {
   setState(() {
     _totalExpense.add(expense);
   });
 }


 void _removeExpense(Expense expense){
   final expenseIndex = _totalExpense.indexOf(expense);//value can be added from the same index it was removed from(DONE USING .insert BELOW)
   setState(() {
     _totalExpense.remove(expense);
   });
   ScaffoldMessenger.of(context).clearSnackBars();
   ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(  duration: Duration(seconds: 2),
       content:const Text('Expense Successfully deleted!!'),
         action: SnackBarAction(label: 'Undo', onPressed: (){
           setState(() {
             _totalExpense.insert(expenseIndex, expense) ;      //here _totalExpense.add(expense) also works but, doesn't present card from the same index it's removed from
                                                                              // (ie:moves to the last index of list when recovered
           });

         }),
       ));
 }


 void _showNewExpensePopUP() {  //the function to which method to add new expense is provided
 showModalBottomSheet(
   useSafeArea: true,
   isScrollControlled: true,
     context: context, builder: (ctx) => AddNewEvents(onAddExpense: (Expense expenses) {
   return _addNewExpense(expenses);
 },)
   );

}
  @override
  Widget build(BuildContext context) {

   var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth =  MediaQuery.of(context).size.width;

   //ternary operation given to a variable to explicitly change its content depending ion the list
   Widget mainContent = _totalExpense.isNotEmpty ?  expenseList(expenses: _totalExpense, onRemoveExpense: _removeExpense)
                                                    : Center(child: Text('Start by creating your first expense'));

    return  Scaffold(appBar: AppBar(title: Text('Expense Tracker'),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {
           _showNewExpensePopUP();
        }, icon: Icon(Icons.add),
        ), SizedBox(width: 20,)
      ],
    ),
      body:screenWidth > 600 ? Expanded(
        child: Row(
          children: [
            Expanded(child: SingleChildScrollView(child: Chart(expenses: _totalExpense ))),
            Expanded(child: mainContent)
          ],
        ),
      )
          : Column(
      children: [SingleChildScrollView(child: Chart(expenses: _totalExpense )),
         Expanded(child: mainContent)
      ],
    ),);
  }
}