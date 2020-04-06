import 'package:flutter/material.dart';
import 'package:get_my_movies/widgets/header.dart';
import 'package:get_my_movies/widgets/trend.dart';

class HomePage extends StatelessWidget {
  final x = List<String>.generate(100000, (i) => "Item $i");
  final q = List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    final List y = [];
    final r = q.length % 3;
    for (var i = 0; i < q.length - r; i += 3) {
      final List a = [q[i], q[i + 1], q[i + 2]];
      y.add(a);
    }
    // handle reset later
    // if (r == 1) {
    //   y.add([])
    // } else if (r == 2) {

    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Logo'),
      ),
      body: ListView.builder(
        itemCount: 1 + y.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Header('Trending'),
                Container(
                  // margin: EdgeInsets.only(top: 10),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: x.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 300,
                        child: Trend(),
                      );
                    },
                  ),
                ),
                Header('Popular')
              ],
            );
          }
          return Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 150,
                color: Colors.red,
                child: Center(
                  child: Text('${y[index - 1][0]}'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 150,
                color: Colors.red,
                child: Center(
                  child: Text('${y[index - 1][1]}'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 150,
                color: Colors.red,
                child: Center(
                  child: Text('${y[index - 1][2]}'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
