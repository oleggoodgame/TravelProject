import 'package:eight/widgets/BuyPage.dart';
import 'package:flutter/material.dart';
import 'package:eight/models/Travel.dart';
import 'package:eight/widgets/BuyedPage.dart';
import 'package:eight/widgets/GPSPage.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() {
    return _TravelPageState();
  }
}

class _TravelPageState extends State<TravelPage> {
  Category _selectedCategory = Category.plane;
  var _activeScreen = 'buy-screen';
  double _globalBalance = 300.0;
  final List<Travel> _planeTravels = [
    Travel(
      title: 'Kyiv to Warsaw',
      category: Category.plane,
      company: 'WizzAir',
      price: 120.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Travel(
      title: 'Lviv to Berlin',
      category: Category.plane,
      company: 'Ryanair',
      price: 95.5,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Travel(
      title: 'Odesa to Istanbul',
      category: Category.plane,
      company: 'Turkish Airlines',
      price: 160.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Travel(
      title: 'Kharkiv to Rome',
      category: Category.plane,
      company: 'SkyUp',
      price: 140.0,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];
  final List<Travel> _carTravels = [
    Travel(
      title: 'Kyiv to Lviv',
      category: Category.car,
      company: 'BlaBlaCar',
      price: 25.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Travel(
      title: 'Dnipro to Kharkiv',
      category: Category.car,
      company: 'Private Driver',
      price: 18.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Travel(
      title: 'Odesa to Mykolaiv',
      category: Category.car,
      company: 'AutoLux',
      price: 15.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Travel(
      title: 'Ternopil to Rivne',
      category: Category.car,
      company: 'CarGo',
      price: 22.5,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Travel(
      title: 'Poltava to Sumy',
      category: Category.car,
      company: 'Local Taxi',
      price: 19.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Travel(
      title: 'Zaporizhzhia to Kryvyi Rih',
      category: Category.car,
      company: 'Shared Ride',
      price: 21.0,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];
  final List<Travel> _trainTravels = [
    Travel(
      title: 'Kyiv to Lviv',
      category: Category.train,
      company: 'Ukrzaliznytsia',
      price: 18.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Travel(
      title: 'Lviv to Uzhhorod',
      category: Category.train,
      company: 'Ukrzaliznytsia',
      price: 20.5,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Travel(
      title: 'Kharkiv to Odesa',
      category: Category.train,
      company: 'Intercity+',
      price: 45.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];
  final List<Travel> _purchasedTrips = [];

  Map<String, Interest> interestsPlane = {
    'Insurance': Interest(selected: true, price: 5.0),
    'Internet': Interest(selected: false, price: 10.0),
    'Books': Interest(selected: false, price: 3.0),
    'Foods': Interest(selected: false, price: 5.0),
  };
  Map<String, Interest> interestCar = {
    'Insurance': Interest(selected: true, price: 5.0),
    'Foods': Interest(selected: false, price: 3.0),
    'Music': Interest(selected: false, price: 0.0),
  };
  Map<String, Interest> interestTrain = {
    'Insurance': Interest(selected: true, price: 5.0),
    'Foods': Interest(selected: false, price: 3.0),
    'Blanket': Interest(selected: false, price: 5.0),
    'Internet': Interest(selected: false, price: 6.0),
  };
  void _switchScreenMail() {
    setState(() {
      _activeScreen = 'email-screen';
    });
  }

  void _switchScreenPurchased() {
    setState(() {
      _activeScreen = 'buy-screen';
    });
  }

  void _switchScreenGPS() {
    setState(() {
      _activeScreen = 'gps-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = const SizedBox();
    if (_activeScreen == 'buy-screen') {
      screenWidget = Buypage(
        selectedCategory: _selectedCategory,
        onCategoryChanged: onCategoryChanged,

        planeTravels: _planeTravels,
        carTravels: _carTravels,
        trainTravels: _trainTravels,
        onTravelTap: _onTravelTap,
      );
    } else if (_activeScreen == 'email-screen') {
      screenWidget = PurchasedTripsScreen(
        _onReturnTap,
        purchasedTrips: _purchasedTrips,
      );
    } else if (_activeScreen == 'gps-screen') {
      screenWidget = PlaceholderScreenGPS();
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.online_prediction_rounded),
              onPressed: _switchScreenPurchased,
            ),
            IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: _switchScreenGPS,
            ),
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: _switchScreenMail,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Balance:"),
                Text("$_globalBalance\$"),
              ], // З ЦИМ ПРОБЛЕМА, КОЛИ Я КУПЛЯЮ ВОНО ОНВЛЮЄТЬСЯ ЯКЩО Я ПЕРЕХОЖУ НА ІНШИЙ ЕКРАН, але повернення працює нормально
            ),
          ],
        ),
      ),

      body: screenWidget,
    ); //
  }

  void onCategoryChanged(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onTravelTap(BuildContext context, Travel travel) {
    double finalPrice = travel.price;
    double totalExtras = 0.0;
    showDialog(
      context: context,
      builder: (ctx) {
        // Копіюємо інтереси, щоб не псувати глобальні
        final Map<String, Interest> localInterests = {
          for (var entry in _getInterestsForCategory(travel.category).entries)
            entry.key: Interest(
              selected: entry.value.selected,
              price: entry.value.price,
            ),
        };

        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: Text('Підтвердити покупку?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ви хочете купити "${travel.title}" за ${travel.price}\$?',
                  ),
                  const SizedBox(height: 12),
                  ...localInterests.entries.map((entry) {
                    return CheckboxListTile(
                      title: Text('${entry.key} (+${entry.value.price}\$)'),
                      value: entry.value.selected,
                      onChanged: (newValue) {
                        setState(() {
                          localInterests[entry.key]!.selected = newValue!;
                        });
                      },
                    );
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Скасувати'),
                ),
                TextButton(
                  onPressed: () {
                    for (var entry in localInterests.entries) {
                      if (entry.value.selected) {
                        totalExtras += entry.value.price;
                      }
                    }

                    finalPrice += totalExtras;

                    if (_globalBalance >= finalPrice) {
                      Navigator.of(ctx).pop(); // закриваємо діалог
                      _purchaseTravel(
                        context,
                        travel,
                        totalExtras,
                      ); // 🎯 сюди все пішло
                    } else {
                      Navigator.of(ctx).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Недостатньо коштів')),
                      );
                    }
                  },
                  child: const Text('Купити'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onReturnTap(BuildContext context, Travel travel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Підтвердити повернення?'),
        content: Text(
          'Вам повернуть "${travel.finalPrice}"\$ від поїздки "${travel.title}"',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // закрити діалог
            },
            child: const Text('Скасувати'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _globalBalance += travel.finalPrice;
                _purchasedTrips.remove(travel);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Повернено "${travel.title}". Баланс: $_globalBalance',
                  ),
                ),
              );
              travel.finalPrice = travel.price;
              if (travel.category == Category.plane) {
                setState(() {
                  _planeTravels.add(travel);
                });
              } else if (travel.category == Category.car) {
                setState(() {
                  _carTravels.add(travel);
                });
              } else {
                setState(() {
                  _trainTravels.add(travel);
                });
              }
              Navigator.of(ctx).pop(); // закрити діалог
            },
            child: const Text('Повернути'),
          ),
        ],
      ),
    );
  }

  void _purchaseTravel(
    BuildContext context,
    Travel travel,
    double totalExtras,
  ) {
    final double finalPrice = travel.price + totalExtras;
    travel.finalPrice = finalPrice;
    setState(() {
      _globalBalance -= finalPrice;
      _purchasedTrips.add(travel);

      if (travel.category == Category.plane) {
        _planeTravels.remove(travel);
      } else if (travel.category == Category.car) {
        _carTravels.remove(travel);
      } else {
        _trainTravels.remove(travel);
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Куплено "${travel.title}". Баланс: $_globalBalance\$'),
      ),
    );
  }

  Map<String, Interest> _getInterestsForCategory(Category category) {
    switch (category) {
      case Category.plane:
        return interestsPlane;
      case Category.car:
        return interestCar;
      case Category.train:
        return interestTrain;
    }
  }
}
