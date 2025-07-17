import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';
import 'package:eight/widgets/listview/listview.dart';

class TrainList extends StatelessWidget {
  const TrainList(this.onTap, {super.key, required this.dummyTrainTravels});

  final List<Travel> dummyTrainTravels;
    final void Function(BuildContext context, Travel travel) onTap;

  @override
  Widget build(BuildContext context) {
    return TravelList(onTap,  travels: dummyTrainTravels);
  }

  void deleteTravel(Travel travel){
    dummyTrainTravels.remove(travel);
  }
}
