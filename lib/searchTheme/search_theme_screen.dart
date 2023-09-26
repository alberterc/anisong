import 'package:flutter/material.dart';
import 'package:anisong/data/api.dart';

class SearchThemeScreen extends StatefulWidget {
  const SearchThemeScreen({super.key, required this.dataId});
  final String dataId;

  @override
  State<SearchThemeScreen> createState() => SearchThemeScreenState();
}

class SearchThemeScreenState extends State<SearchThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map?>(
            future: Anime.getThemes(widget.dataId),
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
    );
  }
}
