import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';
import 'package:eight/widgets/listview/listview.dart';

class PurchasedTripsScreen extends StatelessWidget {
  final List<Travel> purchasedTrips;
  final void Function(BuildContext, Travel) onTravelTap;

  const PurchasedTripsScreen(this.onTravelTap,
    {
    super.key,
    required this.purchasedTrips,
  });

  @override
  Widget build(BuildContext context) {
    if (purchasedTrips.isEmpty) {
      return Center(
        child: Text(
          'Ви ще нічого не купили',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return TravelList(onTravelTap, travels: purchasedTrips);
  }
}
