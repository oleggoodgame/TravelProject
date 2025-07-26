import 'package:eight/providers/travelProvider.dart';
import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';
import 'package:eight/widgets/PlainTravels.dart';
import 'package:eight/widgets/CarTravels.dart';
import 'package:eight/widgets/TrainTravels.dart';
import 'package:eight/widgets/AddNewTravel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Map<Filter, String> filterLabels = {
  Filter.price_higher: 'Price ↑',
  Filter.price_low: 'Price ↓',
  Filter.days: 'Earliest Date',
};

class Buypage extends ConsumerWidget {
  final Category selectedCategory;
  final Function(Category) onCategoryChanged;
  final void Function(BuildContext, Travel) onTravelTap;
  final List<Travel> planeTravels;
  final List<Travel> carTravels;
  final List<Travel> trainTravels;
  final void Function(Travel) onAddTravel;
  final User user;
  final AppBar appBar;
  const Buypage({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onTravelTap,
    required this.planeTravels,
    required this.carTravels,
    required this.trainTravels,
    required this.onAddTravel,
    required this.user,
    required this.appBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget travelListWidget;
    List<Travel> sortedTravels = [];
    final selectedFilter = ref.watch(filterProvider);
    if (selectedCategory == Category.plane) {
      sortedTravels = [...planeTravels];

      travelListWidget = PlaneList(
        onTravelTap,
        dummyPlaneTravels: sortedTravels,
      );
      
    } else if (selectedCategory == Category.car) {
      sortedTravels = [...carTravels];
      travelListWidget = CarList(onTravelTap, dummyCarTravels: sortedTravels);
    } else {
      sortedTravels = [...trainTravels];
      travelListWidget = TrainList(
        onTravelTap,
        dummyTrainTravels: sortedTravels,
      );
    }
    if (selectedFilter != null) {
      switch (selectedFilter) {
        case Filter.price_higher:
          sortedTravels.sort((a, b) => b.price.compareTo(a.price));
          break;
        case Filter.price_low:
          sortedTravels.sort((a, b) => a.price.compareTo(b.price));
          break;
        case Filter.days:
          sortedTravels.sort((a, b) => a.date.compareTo(b.date));
          break;
      }
    }
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  value: selectedCategory,
                  alignment: Alignment.center,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          alignment: Alignment.center, 
                          child: Row(
                            children: [
                              Icon(categoryIcons[category]),
                              const SizedBox(width: 8),
                              Text(category.name.toUpperCase(), textAlign: TextAlign.center,),
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
              ),
              Expanded(
                child: DropdownButton<Filter>(
                  value: selectedFilter,
                  alignment: Alignment.center,
                  hint: const Text('Sort by'),
                  items: Filter.values.map((filter) {
                    return DropdownMenuItem(
                      alignment: Alignment.center, 
                      value: filter,
                      child: Text(filterLabels[filter]!, textAlign: TextAlign.center),
                    );
                  }).toList(),
                  onChanged: (value) {
                    ref.read(filterProvider.notifier).setFilter(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Expanded(child: travelListWidget),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) =>
                  NewTravel(onAddExpense: onAddTravel, user: user),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
