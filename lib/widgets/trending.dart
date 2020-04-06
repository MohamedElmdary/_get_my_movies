import 'package:flutter/material.dart';
import 'package:get_my_movies/models/trend.dart';
import 'package:get_my_movies/providers/trend.dart';
import 'package:get_my_movies/widgets/trend_movie.dart';
import 'package:provider/provider.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TrendMovie> movies = Provider.of<TrendState>(context).movies;

    Widget _child = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print('should go to view full movie page (${movies[index].title})');
          },
          child: TrendMovieWidget(movies[index]),
        );
      },
    );

    if (movies.length == 0) {
      _child = Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      // margin: EdgeInsets.only(top: 10),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: _child,
    );
  }
}
