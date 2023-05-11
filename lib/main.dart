import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_mentor/app.dart';
import 'package:online_mentor/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDi();
  await Firebase.initializeApp();

  runApp(MyApp());
}
