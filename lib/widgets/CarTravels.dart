import 'package:eight/widgets/listview/listview.dart';
import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';

class CarList extends StatelessWidget {
  const CarList(this.onTap, {super.key, required this.dummyCarTravels});

  final List<Travel> dummyCarTravels;
  final void Function(BuildContext context, Travel travel) onTap;

  @override
  Widget build(BuildContext context) {
    return TravelList(onTap, travels: dummyCarTravels);
  }

  void deleteTravel(Travel travel){
    dummyCarTravels.remove(travel);
  }
}
