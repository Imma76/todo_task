import 'package:flutter/widgets.dart';

class Todo extends ChangeNotifier{
  String? title;
  String? description;
  bool isDone;
  String? id;
  Todo({this.description, this.isDone = false, this.title, this.id});

 void toggle(){
   isDone = !isDone;
   notifyListeners();
   print("hey");
 }
}