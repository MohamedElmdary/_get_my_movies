import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/models/trend.dart';

class TrendMovieWidget extends StatelessWidget {
  final TrendMovie movie;
  TrendMovieWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: Env.imageApi(movie.poster_path),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        placeholder: (context, url) {
          return CircularProgressIndicator();
          // 'assets/images/placeholder.png'
        },
      ),
    );
  }
}
