import 'package:flutter/material.dart';

class Movie extends StatelessWidget {
  final int n;
  final String data;
  Movie(this.n, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / n,
      padding: EdgeInsets.only(
        left: 7,
        right: 7,
        bottom: 15,
      ),
      height: 250,
      child: Card(
        margin: EdgeInsets.zero,
        child: Center(
          child: Text('$data'),
        ),
      ),
    );
  }
}
