//import 'package:contact_app/views/homepage_screen.dart';
//import 'package:contact_app/views/display_data_screen.dart';
//import 'package:contact_app/views/update_data_screen.dart';
//import 'package:contact_app/views/insert_data_screen.dart';
//import 'package:contact_app/views/delete_data_screen.dart';
import 'package:contact_app/views/query_data_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact App',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const QueryDatabase(),
    );
  }
}
