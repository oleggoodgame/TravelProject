import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';
import 'package:eight/widgets/listview/listview.dart';

class PurchasedTripsScreen extends StatelessWidget {
  final List<Travel> purchasedTrips;
  final void Function(BuildContext, Travel) onTravelTap;
  final AppBar appBar;

  const PurchasedTripsScreen(
    this.onTravelTap, {
    super.key,
    required this.purchasedTrips,
    required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 16,0, 0),
        child: purchasedTrips.isEmpty
            ? Center(
                child: Text(
                  'You nothing bought',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            : TravelList(onTravelTap, travels: purchasedTrips),
      ),
    );
  }
}
