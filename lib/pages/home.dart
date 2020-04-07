import 'package:flutter/material.dart';
import 'package:get_my_movies/helpers/offset.dart';
import 'package:get_my_movies/providers/movies.dart';
import 'package:get_my_movies/widgets/header.dart';
import 'package:get_my_movies/widgets/movie_card.dart';
import 'package:get_my_movies/widgets/trending.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with OffsetHelper {
  @override
  Widget build(BuildContext context) {
    int n = 2;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      n = 3;
    }

    MoviesState state = Provider.of<MoviesState>(context);
    var changes = state.changes;

    final List<List<int>> moviesId = [];
    final its = changes.length - (changes.length % n);
    for (var i = 0; i < its; i += 3) {
      final List<int> moviesIdList = [];
      for (var j = 0; j < n; j++) {
        moviesIdList.add(changes[i + j]);
      }
      moviesId.add(moviesIdList);
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
        itemCount: 1 + moviesId.length,
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

          final List<Widget> children = [];
          for (var i = 0; i < n; i++) {
            children.add(MovieCard(n, moviesId[index - 1][i]));
          }
          return Row(
            children: children,
          );
        },
      ),
    );
  }
}
