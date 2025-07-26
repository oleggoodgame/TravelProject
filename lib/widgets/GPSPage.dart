import 'package:flutter/material.dart';

class PlaceholderScreenGPS extends StatelessWidget {
  final AppBar appBar;

  const PlaceholderScreenGPS({super.key, required this.appBar,});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Text(
          'We don\'t add this function',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
