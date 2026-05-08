import 'package:flutter/material.dart';
import 'package:learning/widgets/expenses_list/expensesItem_card.dart';

import '../models/expense_model.dart';
import '../models/expense_model.dart' as expense;

class AddNewEvents extends StatefulWidget {
  AddNewEvents({super.key,required this.onAddExpense});

  void Function(Expense expenses)  onAddExpense;

  @override
  State<AddNewEvents> createState() => _AddNewEventsState();
}

class _AddNewEventsState extends State<AddNewEvents> {



  final TitleController = TextEditingController();
  final PriceContoller =TextEditingController();

  Category _selectedCategory = Category.food;



  void _saveExpensesButton() {
    //variable created to avoid non integer values or 'int' values lesser than 0 to be entered
    //double.tryParse('hello')=null , double.tryParse('1.23')=1.23
   final amountEntered = double.tryParse(PriceContoller.text);

final amountIsInvalid = amountEntered == null || amountEntered<=0; //clubbed two conditions in one variable, can be done separately too

    if(TitleController.text.trim().isEmpty || amountIsInvalid|| chosenDate == null){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Invalid input!!'),
        content: Text('Please check if u have entered title, price, date and category.'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          } , child: Text('okay'))
        ],
      ),);
    }
    else {
        widget.onAddExpense(Expense(name: TitleController.text, date: chosenDate!, price: amountEntered, category: _selectedCategory));

      Navigator.pop(context);
    }
  }



 DateTime? chosenDate;

  void showDate () async {
    DateTime? datePicked = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100,),initialDate: DateTime.now());
    setState(()  {
      chosenDate =  datePicked;
    });
  }

  @override
  void dispose() {
    super.dispose();
    TitleController.dispose();
    PriceContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //media query can be used as usual , using an alternative widget called as the layout builder for the same

    
        final keyboardSpace =MediaQuery.of(context).viewInsets.bottom;
      return LayoutBuilder(builder: (context, constraints) {
         final width = constraints.maxWidth;
         return SizedBox(height: double.infinity,
           child: SingleChildScrollView(
             child: Padding(
               padding:  EdgeInsets.fromLTRB(16,48,16,keyboardSpace+5),
               child:
                 Column(
                 children: [
                   if(width>=400)
                     Row(crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: TextField(maxLength: 50,
                             controller: TitleController,
                             decoration: InputDecoration(
                               hintText: 'Title',
                             ),
                           ),
                         ),Spacer(),
                         Expanded(
                           child: TextField(
                             keyboardType: TextInputType.number,
                             controller: PriceContoller,
                             decoration: InputDecoration(
                                 hintText: 'Price',
                                 prefixText: '₹ '
                             ),
                           ),
                         ),
                       ],
                     )
                   else
                   TextField(
                     maxLength: 50,
                     controller: TitleController,
                     decoration: InputDecoration(
                       hintText: 'Title',

                     ),
                   ),SizedBox(height: 15),
              if(width>400)
                Row(children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map((category) =>
                          DropdownMenuItem(value: category,
                              child: Text(category.name.toUpperCase()))).toList(),

                      onChanged: (categoryValue) {
                        if(categoryValue == null) {
                          return;
                        }setState(() {
                          _selectedCategory = categoryValue;
                        });


                      }),
                  Spacer(),
                  Text(chosenDate == null
                      ? 'Select-date'
                      :  formattedDate.format(chosenDate!)
                  ),
                  IconButton(
                    onPressed: () => showDate(),  icon: Icon(Icons.calendar_month),
                  ),
                ],)
              else
                   Row(
                     children: [
                       Expanded(
                         child: TextField(
                           keyboardType: TextInputType.number,
                           controller: PriceContoller,
                           decoration: InputDecoration(
                               hintText: 'Price',
                               prefixText: '₹ '
                           ),
                         ),
                       ),
                       Spacer(),
                       Text(chosenDate == null
                           ? 'Select-date'
                           :  formattedDate.format(chosenDate!)
                       ),
                       IconButton(
                         onPressed: () => showDate(),  icon: Icon(Icons.calendar_month),
                       )],
                   ),

                   SizedBox(height: 15 ),

                   Row(
                     children: [
                       if(width>0)
                         Spacer(),
                       ElevatedButton(style: ButtonStyle(backgroundColor:WidgetStateColor.resolveWith((states) => Colors.red,) ),
                           onPressed: () {
                             Navigator.pop(context);
                           }, child: Text('Cancel')),
                       SizedBox(width: 5),
                       ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => Colors.green,)),
                           onPressed: () {
                             _saveExpensesButton();
                           }, child: Text('Save Expense'))
                     ],
                   )

                 ],
               ),
             ),
           ),
         );
        },);


  }
}