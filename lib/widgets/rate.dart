import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final double rate;
  Rate(this.rate);

  @override
  Widget build(BuildContext context) {
    final double r = rate / 2;
    final int fStars = r.floor();
    final List<Widget> children = [];

    for (var i = 0; i < fStars; i++) {
      children.add(Icon(
        Icons.star,
        color: Colors.amber,
        size: 20,
      ));
    }

    if (r - fStars >= 0.5) {
      children.add(Icon(
        Icons.star_half,
        color: Colors.amber,
        size: 20,
      ));
    }

    for (var i = 0; i <= 5 - children.length; i++) {
      children.add(Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 20,
      ));
    }

    children.add(
      Container(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          '$rate / 10',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );

    return Row(
      children: children,
    );
  }
}