import 'package:flutter/material.dart';
import 'package:eight/widgets/TravelPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 197, 15, 15),
);
void main() {
  runApp(
    MaterialApp(
      
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            
          ),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
          labelSmall: TextStyle(fontSize: 12, color: Colors.black),
        ),
        
      ),
      home: ProviderScope(child: const TravelPage()),
    ),
  );
}
