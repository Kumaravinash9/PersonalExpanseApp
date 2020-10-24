

import 'package:flutter/cupertino.dart';

class Transaction
{

final int id;
final String name;
final double  amount;
final DateTime day;

Transaction({
@required this.id,@required this.name,
@required this.amount,@required this.day, 
});


}