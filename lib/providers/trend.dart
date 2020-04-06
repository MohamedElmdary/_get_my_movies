import 'package:flutter/material.dart';
import 'package:get_my_movies/apis/tmdb.dart';
import 'package:get_my_movies/models/trend.dart';

class TrendState with ChangeNotifier {
  // page number
  int _page = 1;
  get page => _page;
  void incrementPage() {
    _page++;
  }

  // trend movies
  final List<TrendMovie> _movies = [];
  List<TrendMovie> get movies => List.from(_movies);

  // handle error
  String _error;
  get error => _error;

  getMoreTrendMovies() {
    TMDBApi.getTrendMovies(_page).then((respond) {
      if (respond.success) {
        _movies.addAll(respond.result);
        incrementPage();
      } else {
        _error = respond.error;
      }
      notifyListeners();
    }).catchError((_) {
      print('here ?');
      _error = 'Something Went Wrong!';
      notifyListeners();
    });
  }

  TrendState() {
    getMoreTrendMovies();
  }
}
