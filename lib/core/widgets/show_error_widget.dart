import 'package:flutter/material.dart';

class ShowErrorWidget extends StatelessWidget {
  final String message;
  const ShowErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            key: Key("error_icon"),
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          SizedBox(height: 8),
          Text(
            'Something went wrong!',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          SizedBox(height: 4),
          Text(
            message.toString(),
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
