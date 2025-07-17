import 'package:eight/models/Travel.dart';
import 'package:flutter/material.dart';


class TravelItem extends StatelessWidget {
  const TravelItem(this.travel, {super.key});

  final Travel travel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              travel.title,
              style:  Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(categoryIcons[travel.category]),
                    Text(travel.company),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${travel.price.toStringAsFixed(2)}\$'),
                    Text(travel.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

