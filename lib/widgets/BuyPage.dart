import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';
import 'package:eight/widgets/PlainTravels.dart';
import 'package:eight/widgets/CarTravels.dart';
import 'package:eight/widgets/TrainTravels.dart';

class Buypage extends StatelessWidget {
  final Category selectedCategory;
  final Function(Category) onCategoryChanged;
  final void Function(BuildContext, Travel) onTravelTap;
  final List<Travel> planeTravels;
  final List<Travel> carTravels;
  final List<Travel> trainTravels;
  const Buypage({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onTravelTap,
    required this.planeTravels,
    required this.carTravels,
    required this.trainTravels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(
          value: selectedCategory,
          items: Category.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Row(
                    children: [
                      Icon(categoryIcons[category]),
                      Text(category.name.toUpperCase()),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onCategoryChanged(value);
            }
          },
        ),
        const SizedBox(height: 5),
        Expanded(
          child: selectedCategory == Category.plane
              ? PlaneList(onTravelTap, dummyPlaneTravels: planeTravels)
              : selectedCategory == Category.car
                  ? CarList(onTravelTap, dummyCarTravels: carTravels)
                  : TrainList(onTravelTap, dummyTrainTravels: trainTravels),
        ),
      ],
    );
  }
}
