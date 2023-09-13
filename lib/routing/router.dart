import 'package:flutter/material.dart';
import 'package:scheduleapp/view/calendar/calendar_screen.dart';
import 'package:scheduleapp/view/event/add_event_screen.dart';
import 'package:scheduleapp/view/event/edit_event_screen.dart';
import 'package:scheduleapp/main.dart';

class AppRoutes {
  static get id => null;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const MyHomePage());
      case '/calendar':
        return MaterialPageRoute(builder: (context) => CalendarScreen());
      case '/add_event':
        return MaterialPageRoute(builder: (context) => const AddEventScreen());
      case '/edit_event':
        final args = settings.arguments;
        if (args is int) {
          return MaterialPageRoute(
            builder: (context) => EditEventScreen(args),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found.'),
        ),
      ),
    );
  }
}
