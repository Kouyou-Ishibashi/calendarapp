import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scheduleapp/routing/router.dart';
import 'package:scheduleapp/service/database/database.dart';
import 'package:scheduleapp/service/providers/event_provider.dart';

void main() {
  initializeDateFormatting("ja_JP");
  runApp(const ProviderScope(child: MyApp())); //変更
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.generateRoute,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', ''), //日本語
      ],
      locale: const Locale('ja'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _MyHomePageState createState() => _MyHomePageState(
        database: database,
      );
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({
    required this.database,
  });

  final AppDatabase database;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOP画面'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              child: const Text('カレンダー'),
            ),
          ],
        ),
      ),
    );
  }
}
