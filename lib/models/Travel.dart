import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Category { plane, car, train}

const categoryIcons = {
  Category.plane: Icons.flight_takeoff,
  Category.car: Icons.directions_car,
  Category.train: Icons.train,
};

class Travel {
  Travel({
    required this.title,
    required this.category,
    required this.company,
    required this.price,
    required this.date,
    double? initialFinalPrice,  
  }) : finalPrice = initialFinalPrice ?? price;

  final String title;
  final Category category;
  final String company;
  final double price;
  double finalPrice; 
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}


class Interest {
  bool selected;
  double price;

  Interest({required this.selected, required this.price});
}

class User{
  int id;
  String name;
  User({required this.id, required this.name});
}