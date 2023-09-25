import 'package:flutter/material.dart';
import 'package:anisong/data/api.dart';

class SearchThemeScreen extends StatefulWidget {
  const SearchThemeScreen({super.key});

  @override
  State<SearchThemeScreen> createState() => SearchThemeScreenState();
}

class SearchThemeScreenState extends State<SearchThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Map?>(
              future: Anime.getThemes('40748'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.toString());
                  }
                }
                else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              },
            ),
        ),
      ),
    );
  }
}
