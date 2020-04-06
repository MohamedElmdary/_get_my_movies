import 'package:flutter/material.dart';
import 'package:get_my_movies/pages/home.dart';
import 'package:get_my_movies/providers/trend.dart';
import 'package:provider/provider.dart';

void main() {
  Widget app = MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => TrendState(),
      )
    ],
    child: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Montserrat",
        brightness: Brightness.dark,
      ),
      home: HomePage(),
      // home: Scaffold(
      //   body: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Center(
      //         child: Text('Get My Movies'),
      //       ),
      //       SizedBox(height: 10),
      //       Center(
      //         child: Text(
      //           'Get My Movies',
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      routes: {
        // '/': (context) {
        //   return HomePage();
        // }
      },
    );
  }
}
