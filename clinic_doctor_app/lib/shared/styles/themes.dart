import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(context) => ThemeData(
      textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
      appBarTheme: AppBarTheme(
        //backgroundColor: Colors.white10,
        elevation: 0.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[800],
      ),
    );
