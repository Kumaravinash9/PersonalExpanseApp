

import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'PersonalApp.dart';

class Listview extends StatefulWidget 
{

   List<Transaction>_transaction;
   Function _delect;
   Listview(this._transaction,this._delect);
   @override
  _ListviewState createState() => _ListviewState();

 }
class _ListviewState extends State<Listview> {
  
  List<Color>_colors=[Colors.blue,Colors.cyanAccent,Colors.indigo,Colors.indigoAccent];

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body:ListView.builder(itemCount: widget._transaction.length,itemBuilder: (context,index){
           return
              Card
        (
              elevation: 3,
              child: ListTile(
              title: Text(widget._transaction[index].name,style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Grandstander'
              ),),
              subtitle: Text(DateFormat.yMMMEd().format(widget._transaction[index].day)),
              leading: CircleAvatar(
              radius: 28,
              child: FittedBox(child: Text(" \$ ${widget._transaction[index].amount.toString()}",style: TextStyle(
              fontFamily: 'Grandstander',
              color: Colors.white

              ),)),
              backgroundColor: _colors[Random().nextInt(4)],
              ),
              trailing: InkWell(child: Icon(Icons.delete,color: Colors.red,),
              onTap: ()
              {
                widget._delect(widget._transaction[index].day);
              } 
             ),)
             ,);

        })
    );
         }
}