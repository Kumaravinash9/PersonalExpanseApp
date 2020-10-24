

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  List _transaction;
  double maxSpending;
  Chart(this._transaction,this. maxSpending );

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
      List <Map<String,Object>>get groupeditem{
      return List.generate(7, (index) {
      final weekDay=DateTime.now().subtract(Duration(days: index));
      double amount=0;
      for(int i=0;i<widget._transaction.length;i++)
      if(widget._transaction[i].day.day==weekDay.day&&widget._transaction[i].day.month==weekDay.month)
      amount+=widget._transaction[i].amount;
      if(widget.maxSpending==0)
      widget.maxSpending=1;
      return {
      'days':weekDay,

      'amount':amount/widget.maxSpending,

      "totalValue":amount.toStringAsFixed(2)
     };

     }).toList();
     }

  @override
  Widget build(BuildContext context) {
    
    return 
       Padding(
         padding: const EdgeInsets.all(4.0),
         child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: groupeditem.map((e) {
                        return Flexible(
                           child: Column(
                             children: [
                               FittedBox(child: Container(
                                 margin: EdgeInsets.only(left:5,right:5),
                                                                child: Text("\$${(e["totalValue"]).toString()}",style: TextStyle(
                                   fontSize: 16,fontWeight: FontWeight.w700
                                 ),),
                               )),
                               
                                 SizedBox(height:5),
                                Container
                               (
                                        height: 100,
                                        width: 15,
                                        margin: const EdgeInsets.symmetric(horizontal:16,vertical:4),
                                        decoration: BoxDecoration
                                      (
                                        border: Border.all(width:1,color: Colors.purple),
                                        borderRadius: BorderRadius.all(Radius.circular(125)) 
                                      ),
                                      
                                        child:
                                        FractionallySizedBox(
                                        alignment: Alignment.topCenter,
                                        heightFactor: e["amount"],
                                        widthFactor: .9,
                                        child: Container(
                                        decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius: BorderRadius.all(Radius.circular(125)) 
         
                                     ),
                                     ),
                                     ),),
                                     FittedBox(child: Text(DateFormat.MEd().format(e["days"]).substring(0,1),style: TextStyle(
                                       fontWeight: FontWeight.w700
                                     ),)),
                                     SizedBox(height:5),
                             ],
                           ),);
                                 }).toList()
   
    ),
       ); 
  }
}
