
import 'dart:ffi';
import 'dart:ui';

import 'package:PersonalExpanses/PersonalExpanses/ListView.dart';
import 'package:PersonalExpanses/PersonalExpanses/PersonalApp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Chart.dart';


   
class PersonalExpanses extends StatefulWidget {
  @override
  _PersonalExpansesState createState() => _PersonalExpansesState();
}

class _PersonalExpansesState extends State<PersonalExpanses> {

  List<Transaction>_transaction =
  [
    Transaction(id: 1, name: "Grocies", amount: 260.90, day: DateTime.now()),
    Transaction(id: 1, name: "Iphone", amount: 199.90, day: DateTime.now()),
    Transaction(id: 2, name: "Household items", amount: 79.09 , day: DateTime.now().subtract(Duration(days: 1))),
    Transaction(id: 2, name: "Toys", amount: 970.09 , day: DateTime.now().subtract(Duration(days: 7))),
  
   
  ];

  double get maxSpending
   {

     return _transaction.fold(0.0, (sum, element)  
     {
        return sum+((element.amount));
     });

   }
  

          void _delect(DateTime day)
         {
                setState(() {
                 _transaction.removeWhere((element) => element.day.millisecond==day.millisecond);
                  });
         }

   
     void _addElement(int id,String name,double amount,DateTime day)
      {
          setState(() {
          _transaction.add(Transaction(id: id,name: name,amount:amount ,day: day)
      );
     });
     }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       
     appBar: AppBar(
     title: Text("Personal Expanses"),
     centerTitle: false,
     actions: [
         IconButton(icon: Icon(Icons.add), onPressed: (){
        _showModel(context,_addElement);
      })
    ],),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        
        margin:const EdgeInsets.only(bottom:20),
        height: 70,
        width: 70,
        child: FittedBox(
                  child: FloatingActionButton(
          elevation: 10,
       
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add,size: 30,),
          
          onPressed: () {
          _showModel(context,_addElement);
          } ),
        ),
      ),

      body:Column(
      children:<Widget>[
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
              elevation: 10,
              child: Container(
              height: 170,
              child: Chart( _transaction,maxSpending),

         ),
      ),
      ),

      Expanded
      (
            child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 400,
            child:_transaction.length==0? 
            Stack(
              alignment: Alignment.topCenter,
               children: [
                 Center(
                    child: Image.asset("assets/waiting.png",height: 400,filterQuality: FilterQuality.high,),
                  ),
                  
                     Text("No Transaction is added yet",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily:"Grandstander",
                      fontSize: 22
                    ),),
                  

               ],

            
            )
                    
               
             
               

            
            :Listview(_transaction,_delect),
       ),
     ),
    
      ]
      )

    );
  }
}

/***********************************ListView******************************************************/


void _showModel(BuildContext ctx,Function _addElement)

{   DateTime day;
    var _nameController ;
    var _amountController;
    var bottom=MediaQuery.of(ctx).viewInsets.bottom;

 showModalBottomSheet(context: ctx, builder: (_){
   
    return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(8),
              color: Colors.white,
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                   TextField
                   (
                     decoration: InputDecoration(
                      labelText: "Name",
                      contentPadding: EdgeInsets.all(6),
                      border: OutlineInputBorder(),
                      
                      labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)
                    ),
                      onChanged: (String s)
                     {
                        if(s!=null)
                        _nameController=s;
                     }
                     
                   ),
                   SizedBox(height:10),
                   TextFormField
                    (
                      decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(6),
                      labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                      prefixText: "\$"
                      ),
                     onChanged: (String s)
                     {
                        if(s!=null)
                        _amountController=s;
                     },
                   
                     keyboardType: TextInputType.numberWithOptions(decimal:true),
                     
                    ),
                    SizedBox(height:5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>
                      [ 
                        FlatButton.icon(onPressed: (){
                        showDatePicker(context: _, initialDate: DateTime.now(), firstDate: DateTime(1999), lastDate:DateTime.now()).then((value) {
                        if(value!=null)
                        day=value;
                        }
                        );
                      },
                        icon: Icon(Icons.calendar_today_outlined,color: Colors.blueAccent,),
                        label: Text(day==null?"Calender":DateFormat.yMMMEd().format(day),style: TextStyle(
                        fontStyle: FontStyle.normal,fontWeight: FontWeight.w600
                      ),),
                      ),

                          FlatButton(onPressed: (){
                          if(day==null)
                          day=DateTime.now();
                          if(_nameController!=null&&_amountController!=null) {
                            _addElement(0,_nameController.toString(),double.parse(_amountController.toString()),day);
                          }
                          Navigator.pop(_);
                      }
                      ,   child: Text("AddTransaction"),
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),), 
                      ]
                        
                   )
                   
                  ],
                ),  
            );

 });
}
