import 'package:flutter/material.dart';
import 'package:get_my_movies/providers/movies.dart';
import 'package:get_my_movies/providers/trend.dart';
import 'package:get_my_movies/widgets/trend_movie.dart';
import 'package:provider/provider.dart';

class Trending extends StatelessWidget {
  final Function getOffset;
  final Function setOffset;
  final int currentMovieId;
  final bool recommendations;

  Trending(this.getOffset, this.setOffset,
      {this.currentMovieId, this.recommendations = false});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController(initialScrollOffset: getOffset());
    dynamic state;
    dynamic movies;
    bool loading;

    if (!recommendations) {
      state = Provider.of<TrendState>(context);
      movies = state.movies;
      loading = state.trendLoading;
    } else {
      state = Provider.of<MoviesState>(context);
      movies = state.getMovieRecommendation(currentMovieId);
      loading = state.movieLoading;
    }

    Widget _child = NotificationListener(
      onNotification: (ScrollNotification notification) {
        setOffset(notification.metrics.pixels);
        return true;
      },
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount:
            (recommendations ? 0 : 1) + (movies != null ? movies.length : 0),
        itemBuilder: (context, index) {
          if (recommendations && index == movies.length) {
            return Container(
              padding: EdgeInsets.only(right: 10),
              child: FlatButton(
                child:
                    loading ? CircularProgressIndicator() : Text("Load More"),
                onPressed: () {
                  if (!loading) {
                    state.getMoreTrendMovies();
                  }
                },
              ),
            );
          }
          if (movies[index].id == currentMovieId) {
            return Container();
          }
          return TrendMovieWidget(movies[index]);
        },
      ),
    );

    if (recommendations && movies != null && movies.length == 0) {
      _child = Center(
        child: Text('No Related Videos.'),
      );
    } else if (movies == null || movies.length == 0) {
      _child = Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: _child,
    );
  }
}
