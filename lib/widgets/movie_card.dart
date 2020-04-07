import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/models/movie.dart';
import 'package:get_my_movies/providers/movies.dart';
import 'package:get_my_movies/widgets/rate.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final int n;
  final int movieId;
  MovieCard(this.n, this.movieId);

  Widget _buildTag(MovieModel movie, double top, String value,
      {Color color = Colors.indigoAccent}) {
    return Positioned(
      top: top,
      child: Container(
        height: 30,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: color,
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _loadMovieDetails() {
    print('loading');
  }

  @override
  Widget build(BuildContext context) {
    final MoviesState state = Provider.of<MoviesState>(context);
    final MovieModel movie = state.getFullMovie(movieId);
    final _w = MediaQuery.of(context).size.width / n;
    final double _h = 365;

    return Container(
      width: _w,
      padding: EdgeInsets.only(
        left: 7,
        right: 7,
        bottom: 15,
      ),
      height: _h,
      child: InkWell(
        onTap: _loadMovieDetails,
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: movie == null
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: Env.imageApi(movie.posterPath),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 240,
                          child: Ink.image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: _loadMovieDetails,
                                  child: Container(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ),
                                movie.adult
                                    ? _buildTag(
                                        movie,
                                        20,
                                        'Adults',
                                        color: Colors.redAccent,
                                      )
                                    : Container(),
                                movie.genres.length > 0
                                    ? _buildTag(
                                        movie,
                                        movie.adult ? 60 : 20,
                                        movie.genres[0],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              movie.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Divider(),
                          Rate(movie.voteAverage),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  'Total Votes:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${movie.voteCount}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
