import 'package:flutter/material.dart';
import 'package:get_my_movies/widgets/trend_movie.dart';

class Trending extends StatelessWidget {
  final movies;
  Trending(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 300,
            child: TrendMovie(),
          );
        },
      ),
    );
  }
}
