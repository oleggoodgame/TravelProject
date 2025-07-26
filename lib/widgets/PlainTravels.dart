
import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';
import 'package:eight/widgets/listview/listview.dart';

class PlaneList extends StatelessWidget {
  const PlaneList(this.onTap, { super.key, required this.dummyPlaneTravels});
  final List<Travel> dummyPlaneTravels;
    final void Function(BuildContext context, Travel travel) onTap;

  @override
  Widget build(BuildContext context) {
    return TravelList(onTap,travels: dummyPlaneTravels);
  }
  
  void deleteTravel(Travel travel){
    dummyPlaneTravels.remove(travel);
  }
}
