import 'package:flutter/material.dart';
import 'package:notes_with_firebase/Screens/AddNotesScreen/View/AddNotesPage.dart';

Route animation(){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const AddNotesPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}