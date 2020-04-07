import 'package:flutter/material.dart';
import 'package:get_my_movies/providers/trend.dart';
import 'package:get_my_movies/widgets/trend_movie.dart';
import 'package:provider/provider.dart';

class Trending extends StatelessWidget {
  final Function getOffset;
  final Function setOffset;

  Trending(this.getOffset, this.setOffset);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController(initialScrollOffset: getOffset());
    final TrendState state = Provider.of<TrendState>(context);
    final movies = state.movies;
    final loading = state.trendLoading;

    Widget _child = NotificationListener(
      onNotification: (ScrollNotification notification) {
        setOffset(notification.metrics.pixels);
        return true;
      },
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: 1 + movies.length,
        itemBuilder: (context, index) {
          if (index == movies.length) {
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
          return TrendMovieWidget(movies[index]);
        },
      ),
    );

    if (movies.length == 0) {
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
