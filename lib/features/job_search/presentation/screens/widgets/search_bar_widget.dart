import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSearch;
  final VoidCallback? onFilterTap;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    this.onSearch,
    this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Field
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: (_) => onSearch?.call(),
            decoration: InputDecoration(
              hintText: 'Search job title, keywords...',
              prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        // Filter Button
        ElevatedButton(
          onPressed: onFilterTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(12),
            backgroundColor: Colors.blueAccent,
          ),
          child: Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }
}
