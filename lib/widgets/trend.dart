import 'package:flutter/material.dart';

class Trend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/placeholder.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
