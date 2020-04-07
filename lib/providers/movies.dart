import 'package:flutter/material.dart';
import 'package:get_my_movies/apis/tmdb.dart';
import 'package:get_my_movies/models/movie.dart';

class MoviesState with ChangeNotifier {
  // loading
  bool _movieLoading = false;
  get movieLoading => _movieLoading;
  set movieLoading(bool val) {
    _movieLoading = val;
    notifyListeners();
  }

  // handle error
  String _movieError;
  get movieError => _movieError;
  set movieError(String val) {
    _movieError = val;
    notifyListeners();
  }

  // changes
  List<dynamic> _changes = [];
  List<dynamic> get changes => List.from(_changes);

  // movies
  Map<int, MovieModel> _fullMovies = {};

  MovieModel getFullMovie(int id) {
    if (_fullMovies[id] != null) {
      return _fullMovies[id];
    }
    TMDBApi.getFullMovie(id).then((movie) {
      movieLoading = false;
      if (movie.success) {
        _fullMovies[id] = movie.result;
        notifyListeners();
      } else {
        _movieError = movie.error;
      }
    }).catchError((_) {
      movieLoading = false;
      movieError = 'Something Went Wrong!';
    });
    return null;
  }

  MoviesState() {
    TMDBApi.getMovieChanges().then((changes) {
      movieLoading = false;
      if (changes.success) {
        _changes.addAll(changes.result);
        notifyListeners();
      } else {
        _movieError = changes.error;
      }
    }).catchError((_) {
      movieLoading = false;
      movieError = 'Something Went Wrong!';
    });
  }
}
