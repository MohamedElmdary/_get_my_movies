import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:get_my_movies/environments/api_key.dart';
import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/helpers/offset.dart';
import 'package:get_my_movies/models/movie.dart';
import 'package:get_my_movies/providers/movies.dart';
import 'package:get_my_movies/widgets/header.dart';
import 'package:get_my_movies/widgets/rate.dart';
import 'package:get_my_movies/widgets/trending.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviePage extends StatefulWidget {
  final int id;
  MoviePage(this.id);

  @override
  State<StatefulWidget> createState() {
    return _MoviePage();
  }
}

class _MoviePage extends State<MoviePage> with OffsetHelper {
  Widget _buildTotals(String lead, String value) {
    return Container(
      child: Row(
        children: [
          Text(lead),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(
        bottom: 10,
      ),
    );
  }

  Widget _buildList(String title, List<String> list) {
    final List<Widget> children = [];

    for (int i = 0; i < list.length; i++) {
      children.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.centerLeft,
          child: Text('- ${list[i]}'),
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Column(
            children: children,
          ),
        )
      ],
    );
  }

  Widget _buildImage(MovieModel movie) {
    if (movie.backdropPath == null && movie.posterPath == null) {
      return Container(
        height: 300,
        child: Center(
          child: Text('No Image.'),
        ),
      );
    }

    return CachedNetworkImage(
        imageUrl: Env.imageApi(
          movie.posterPath != null ? movie.posterPath : movie.backdropPath,
        ),
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              color: Colors.black.withOpacity(0.4),
              backgroundBlendMode: BlendMode.colorBurn,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final MoviesState state = Provider.of<MoviesState>(context);
    final MovieModel movie = state.getFullMovie(widget.id);

    return Scaffold(
      body: movie == null
          ? Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      movie.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    background: _buildImage(movie),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Header(movie.title),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          bottom: 15,
                        ),
                        child: Column(
                          children: [
                            Rate(movie.voteAverage),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                movie.releaseDate.replaceAll('-', ' / '),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                movie.overview,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  height: 1.6,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            _buildTotals(
                              'Budget: ',
                              '${movie.budget.floor()}M \$',
                            ),
                            _buildTotals(
                              'Total votes:',
                              '${movie.voteCount}',
                            ),
                            Row(
                              children: [
                                Text('homepage:'),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: OutlineButton(
                                    onPressed: () {
                                      canLaunch(movie.homepage)
                                          .then((can) {
                                            if (can) {
                                              return launch(movie.homepage,
                                                  forceSafariVC: true,
                                                  forceWebView: true,
                                                  enableDomStorage: true);
                                            }
                                            return Future.value(false);
                                          })
                                          .then((opened) {})
                                          .catchError((err) {});
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Transform.rotate(
                                            angle: -45,
                                            child: Icon(Icons.link),
                                          ),
                                        ),
                                        Text('Visit'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            _buildList('Companies', movie.productionCompanies),
                            _buildList('Countries', movie.productionCountries),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Videos",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: OutlineButton(
                                onPressed: () {
                                  FlutterYoutube.playYoutubeVideoById(
                                    apiKey: YT_KEY,
                                    videoId: movie.videos[0],
                                    autoPlay: true,
                                    fullScreen: true,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.play_arrow),
                                    ),
                                    Text(
                                      'Play',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Header('Related'),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Trending(
                          getOffset,
                          setOffset,
                          currentMovieId: movie.id,
                          recommendations: true,
                        ),
                      ),
                      Header('Trends'),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Trending(
                          getOffset,
                          setOffset,
                          currentMovieId: movie.id,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
