import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String data;

  Header(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              data,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
