import 'package:flutter/material.dart';
import 'package:get_my_movies/apis/tmdb.dart';
import 'package:get_my_movies/models/trend.dart';

class TrendState with ChangeNotifier {
  // loading
  bool _trendLoading = false;
  get trendLoading => _trendLoading;
  set trendLoading(bool val) {
    _trendLoading = val;
    notifyListeners();
  }

  // page number
  int _page = 1;
  get page => _page;
  void incrementPage() {
    _page++;
  }

  // trend movies
  final List<BasicMovie> _movies = [];
  List<BasicMovie> get movies => List.from(_movies);

  // handle error
  String _trendError;
  get trendError => _trendError;
  set trendError(String val) {
    _trendError = val;
    notifyListeners();
  }

  getMoreTrendMovies() {
    trendLoading = true;
    TMDBApi.getTrendMovies(_page).then((respond) {
      trendLoading = false;
      if (respond.success) {
        _movies.addAll(respond.result);
        incrementPage();
        notifyListeners();
      } else {
        trendError = respond.error;
      }
    }).catchError((_) {
      trendLoading = false;
      trendError = 'Something Went Wrong!';
    });
  }

  TrendState() {
    getMoreTrendMovies();
  }
}
