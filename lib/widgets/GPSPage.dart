import 'package:flutter/material.dart';

class PlaceholderScreenGPS extends StatelessWidget {
  const PlaceholderScreenGPS({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ми ще цю функцію не додали',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
