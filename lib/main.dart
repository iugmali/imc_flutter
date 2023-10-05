import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:imc_flutter/models/imc.dart';
import 'package:imc_flutter/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ImcAdapter());
  runApp(const MyApp());
}
