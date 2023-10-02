import 'package:anisong/searchTheme/themes_menu.dart';
import 'package:anisong/utility.dart';
import 'package:flutter/material.dart';

class SearchThemeScreen extends StatefulWidget {
  const SearchThemeScreen({super.key, required this.dataId});
  final String dataId;

  @override
  State<SearchThemeScreen> createState() => SearchThemeScreenState();
}

class SearchThemeScreenState extends State<SearchThemeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: screenSize.width,
        child: Center(
          child: SizedBox(
            width: screenSize.width <= Mobile.minScreenWidth ? 450.0 : 750.0,
            child: Column(
              children: [
                ThemesMenu(dataId: widget.dataId)
              ],
            ),
          ),
        ),
      )
    );
  }
}