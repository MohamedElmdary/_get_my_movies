import 'package:flutter/material.dart';
import 'package:get_my_movies/helpers/offset.dart';
import 'package:get_my_movies/widgets/header.dart';
import 'package:get_my_movies/widgets/movie.dart';
import 'package:get_my_movies/widgets/trending.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with OffsetHelper {
  // should be replaced with popular movies
  final q = List<String>.generate(10000, (i) => "movie $i");

  @override
  Widget build(BuildContext context) {
    int n = 2;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      n = 3;
    }
    final List y = [];
    final r = q.length % n;
    for (var i = 0; i < q.length - r; i += n) {
      final List a = [];
      for (var j = 0; j < n; j++) {
        a.add(q[i + j]);
      }
      y.add(a);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Logo'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Center(
                    child: Text('hello world'),
                  );
                },
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 1 + y.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Header('Trending'),
                Trending(getOffset, setOffset),
                Header('Popular Movies'),
              ],
            );
          }

          // check this code later
          final List<Widget> children = [];
          for (var i = 0; i < n; i++) {
            children.add(Movie(n, y[index - 1][i]));
          }
          return Row(
            children: children,
          );
        },
      ),
    );
  }
}
