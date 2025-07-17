import 'package:eight/widgets/listview/listviewItem.dart';
import 'package:flutter/material.dart';

import 'package:eight/models/Travel.dart';

class TravelList extends StatelessWidget {
  const TravelList(this._onTravelTap ,{super.key, required this.travels});
  final void Function(BuildContext context, Travel travel) _onTravelTap;
  final List<Travel> travels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: travels.length,
      itemBuilder: (ctx, index) => InkWell(
        onTap: () => _onTravelTap(context, travels[index]),
        child: TravelItem(travels[index]),
      ),
    );
  }

}
