import 'package:get_my_movies/environments/environment.dart';
import 'package:get_my_movies/models/respond.dart';
import 'package:get_my_movies/models/trend.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class TMDBApi {
  static Future<Respond<TrendModel>> getTrendMovies(int page) async {
    var x = await http.get(Env.trendApi(page));
    if (x.statusCode == 200) {
      TrendModel jsonResponse = convert.jsonDecode(x.body);
      return Respond(true, result: jsonResponse);
    }
    return Respond(false, error: 'Failed To Fetch Trending Movies');
  }
}
