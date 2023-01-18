import 'package:flutter/material.dart';

class MyInheritor extends InheritedWidget{

  dynamic isGiver;
  dynamic isTaker;
  dynamic userName;
  dynamic userMail;
  dynamic uid;

  MyInheritor({
    Key? key,
    required Widget child,

    this.isGiver,
    this.isTaker,
    this.userMail,
    this.userName,
    this.uid,

  }) : super (key: key, child: child);

  static MyInheritor? of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<MyInheritor>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

}