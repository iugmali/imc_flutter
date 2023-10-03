import 'package:flutter/material.dart';
import 'package:imc_flutter/models/imc.dart';
import 'package:imc_flutter/my_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(ImcAdapter());
  runApp(const MyApp());
}
