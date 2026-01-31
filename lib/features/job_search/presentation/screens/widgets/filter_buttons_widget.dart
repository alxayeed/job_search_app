import 'package:flutter/material.dart';

class FilterButtonsWidget extends StatelessWidget {
  final List<String> filters;
  final ValueChanged<String>? onSelected;

  const FilterButtonsWidget({
    Key? key,
    required this.filters,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(filter),
              selected: false,
              onSelected: (_) => onSelected?.call(filter),
              backgroundColor: Colors.white,
              selectedColor: Colors.blueAccent,
              labelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              elevation: 2,
            ),
          );
        }).toList(),
      ),
    );
  }
}
