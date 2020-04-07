import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/models/movie.dart';
import 'package:get_my_movies/models/respond.dart';
import 'package:get_my_movies/models/trend.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class TMDBApi {
  static Future<Res<List<BasicMovie>>> getTrendMovies(int page) {
    return http.get(Env.trendApi(page)).then((req) {
      if (req.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(req.body);
        final res = jsonResponse['results'];
        final List<BasicMovie> result = [];
        for (int i = 0; i < res.length; i++) {
          result.add(
            BasicMovie(
              id: res[i]['id'],
              title: res[i]['title'],
              posterPath: res[i]['poster_path'],
            ),
          );
        }
        return Res(true, result: result);
      }
      return Res(false, error: 'Failed To Fetch Trending Movies.');
    });
  }

  static Future<Res<List<dynamic>>> getMovieChanges() {
    return http.get(Env.movieChanges).then((req) {
      if (req.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(req.body);
        final List<dynamic> res = jsonResponse['results'];
        return Res(true, result: res);
      }
      return Res(false, error: 'Failed To Fetch Movie Changes.');
    });
  }

  static Future<Res<MovieModel>> getFullMovie(int id) {
    return Future.wait([
      http.get(Env.movieDetails(id)),
      http.get(Env.movieVideos(id)),
    ]).then((req) {
      if (req[0].statusCode + req[1].statusCode != 400) {
        return Res(false, error: 'Failed To Fetch Movie Full Details.');
      }
      Map<String, dynamic> detailsResponse = convert.jsonDecode(req[0].body);
      Map<String, dynamic> videosResponse = convert.jsonDecode(req[1].body);
      List<dynamic> videos = videosResponse['results'];

      MovieModel movie = MovieModel(
        id: detailsResponse['id'],
        adult: detailsResponse['adult'],
        budget: detailsResponse['budget'] / 1000000,
        genres: List.from(
          detailsResponse['genres'].map((genre) => genre['name']),
        ),
        homepage: detailsResponse['homepage'],
        title: detailsResponse['title'],
        overview: detailsResponse['overview'],
        backdropPath: detailsResponse['backdrop_path'],
        posterPath: detailsResponse['poster_path'],
        productionCompanies: List.from(
          detailsResponse['production_companies'].map((c) => c['name']),
        ),
        productionCountries: List.from(
          detailsResponse['production_countries'].map((c) => c['name']),
        ),
        releaseDate: detailsResponse['release_date'],
        voteAverage: detailsResponse['vote_average'],
        voteCount: detailsResponse['vote_count'],
        videos: List.from(
          videos.map((video) => video['key']),
        ),
      );
      return Res(true, result: movie);
    });
  }
}
