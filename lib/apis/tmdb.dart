import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/models/respond.dart';
import 'package:get_my_movies/models/trend.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class TMDBApi {
  static Future<Respond<List<TrendMovie>>> getTrendMovies(int page) async {
    var x = await http.get(Env.trendApi(page));
    if (x.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(x.body);
      final res = jsonResponse['results'];
      final List<TrendMovie> result = [];
      for (int i = 0; i < res.length; i++) {
        result.add(
          TrendMovie(
            id: res[i]['id'],
            voteCount: res[i]['vote_count'],
            voteAverage: res[i]['vote_average'],
            title: res[i]['title'],
            releaseDate: res[i]['release_date'],
            originalLanguage: res[i]['original_language'],
            overview: res[i]['overview'],
            posterPath: res[i]['poster_path'],
            backdropPath: res[i]['backdrop_path'],
          ),
        );
      }
      return Respond(true, result: result);
    }
    return Respond(false, error: 'Failed To Fetch Trending Movies');
  }
}
