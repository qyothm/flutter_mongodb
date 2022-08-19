import 'package:contact_app/app/app.dart';
import 'package:contact_app/dbHelper/mongodb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const App());
}
