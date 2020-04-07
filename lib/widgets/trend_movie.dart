import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/models/trend.dart';

class TrendMovieWidget extends StatelessWidget {
  final double _w = 300;
  final BasicMovie movie;

  TrendMovieWidget(this.movie);

  void _loadFullMovieDetails() {
    print('should load (${movie.title})');
  }

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
              imageUrl: Env.imageApi(movie.posterPath),
              imageBuilder: (context, imageProvider) {
                return Container(
                  child: Ink.image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: _loadFullMovieDetails,
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
            child: InkWell(
              onTap: _loadFullMovieDetails,
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
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
