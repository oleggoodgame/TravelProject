import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { price_higher, price_low, days }

final filterProvider = NotifierProvider<FilterNotifier, Filter?>(() {
  return FilterNotifier();
});

class FilterNotifier extends Notifier<Filter?> {
  @override
  Filter? build() {
    return null;
  }

  void setFilter(Filter? newFilter) {
    state = newFilter;
  }

  void clearFilter() {
    state = null;
  }
}

