import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imc_flutter/pages/imc_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        // primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // useMaterial3: true,
      ),
      home: const ImcPage(),
    );
  }
}
