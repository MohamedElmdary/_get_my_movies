class MovieModel {
  int id;
  bool adult;
  double budget;
  List<String> genres;
  String homepage;
  String title;
  String overview;
  String backdropPath;
  String posterPath;
  List<String> productionCompanies;
  List<String> productionCountries;
  String releaseDate;
  double voteAverage;
  int voteCount;
  List<String> videos;

  MovieModel({
    this.id,
    this.adult,
    this.budget,
    this.genres,
    this.homepage,
    this.title,
    this.overview,
    this.backdropPath,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.videos,
  });
}
