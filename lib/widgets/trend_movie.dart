import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/models/trend.dart';

class TrendMovieWidget extends StatelessWidget {
  final TrendMovie movie;
  TrendMovieWidget(this.movie);

  final double _w = 300;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: _w,
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: Env.imageApi(movie.poster_path),
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.1),
                  ],
                  stops: [0, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              width: _w - 20,
              padding: EdgeInsets.only(
                left: 10,
                bottom: 15,
                top: 25,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                movie.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
