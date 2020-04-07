import 'package:get_my_movies/environments/api_key.dart';

class Env {
  static trendApi(int page) {
    return 'https://api.themoviedb.org/3/trending/movie/day?api_key=$API_KEY&page=$page';
  }

  static changesApi(int page) {
    return 'https://api.themoviedb.org/3/movie/changes?api_key=$API_KEY&page=$page';
  }

  static imageApi(String path) {
    return 'https://image.tmdb.org/t/p/original$path';
  }

  static get movieChanges {
    return 'https://api.themoviedb.org/3/movie/changes?api_key=$API_KEY';
  }

  static movieDetails(int movieId) {
    return 'https://api.themoviedb.org/3/movie/$movieId?api_key=$API_KEY';
  }

  static movieVideos(int movieId) {
    return 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$API_KEY';
  }
}
