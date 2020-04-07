import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_my_movies/pages/home.dart';
import 'package:get_my_movies/providers/movies.dart';
import 'package:get_my_movies/providers/trend.dart';
import 'package:provider/provider.dart';

void main() {
  Widget app = MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => TrendState(),
      ),
      ChangeNotifierProvider(
        create: (_) => MoviesState(),
      )
    ],
    child: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    final cacheManager = DefaultCacheManager();
    cacheManager.emptyCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Montserrat",
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
