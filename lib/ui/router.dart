import 'package:easy_notes/ui/views/addNote.dart';
import 'package:easy_notes/ui/views/editNote.dart';
import 'package:easy_notes/ui/views/home.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/addNote':
        return MaterialPageRoute(builder: (_) => AddNote());
      case '/editNote' :
        return MaterialPageRoute(builder: (_) => EditNote());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
