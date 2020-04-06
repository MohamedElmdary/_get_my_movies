class _TrendModel {
  int id;
  int vote_count;
  double vote_average;
  String title;
  String release_date;
  String original_language;
  String overview;
  String poster_path;
  String backdrop_path;
}

class TrendModel {
  int page;
  List<_TrendModel> results;
}
