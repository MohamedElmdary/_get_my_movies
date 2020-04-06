class TrendMovie {
  int id;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String overview;
  String posterPath;
  String backdropPath;

  TrendMovie({
    this.id,
    this.title,
    this.overview,
    this.voteCount,
    this.voteAverage,
    this.releaseDate,
    this.originalLanguage,
    this.posterPath,
    this.backdropPath,
  });
}
