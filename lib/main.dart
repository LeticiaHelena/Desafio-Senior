import 'package:flutter/material.dart';
import 'package:senior_movies/ui/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          hintColor: Colors.white,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            hintStyle: TextStyle(color: Colors.teal),
          )),
    ),
  );
}

