import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitor_ebooks/pages/splash_page.dart';

class LeitorEbookApp extends StatelessWidget {
  const LeitorEbookApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leitor_ebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.arimaTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
