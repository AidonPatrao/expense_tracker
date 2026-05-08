import 'package:flutter/material.dart';

import '../../models/expense_model.dart';

class expensesCard extends StatelessWidget {
  const expensesCard({super.key, required this.expenses});

  final Expense expenses;

  @override
  Widget build(BuildContext context) {
   return  Card(
     child:
   Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
          Text('${expenses.name}',style: Theme.of(context).textTheme.titleLarge),
         Row(
           children: [
             Text('\₹${expenses.price.toStringAsFixed(2)}'),
             Spacer(),

             Row(children: [
               Icon(CategoryIcons[expenses.category]),  //we use square braces when we want to access a specific item in that map
               Text('${expenses.dateFormated}')
             ],)
           ],
         )
       ],

     ),

     );
    //

  }
}