import 'package:eight/models/Travel.dart';
import 'package:flutter/material.dart';

class NewTravel extends StatefulWidget {
  const NewTravel({super.key, required this.onAddExpense, required this.user});

  final void Function(Travel travel) onAddExpense;
  final User user;

  @override
  State<NewTravel> createState() {
    return _NewTravelState();
  }
}

class _NewTravelState extends State<NewTravel> {
  final _amountController = TextEditingController();
  final _startRouteController = TextEditingController();
  final _endRouteController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.car;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final nextYear = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: nextYear,
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final titleController =
        '${_startRouteController.text} to ${_endRouteController.text}';
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleController.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Travel(
        title: titleController,
        company: widget.user.name,
        price: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _startRouteController.dispose();
    _endRouteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 48),
      child: Column(
        children: [
          Text("NEW TRAVEL", style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _startRouteController,
                  maxLength: 100,
                  decoration: InputDecoration(
                    label: Text(
                      'Where are you coming from',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _endRouteController,
                  maxLength: 100,
                  decoration: InputDecoration(
                    label: Text(
                      'Where are you going',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    if (value != Category.car) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Access Denied'),
                          content: const Text('You don\'t have access'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text(
                      'Amount',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Company: ${widget.user.name}",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save Expense'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
