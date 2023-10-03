import 'package:anisong/searchItem/item_details.dart';
import 'package:anisong/searchItem/item_themes.dart';
import 'package:anisong/utility.dart';
import 'package:flutter/material.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({super.key, required this.dataId, required this.dataImage, required this.dataTitles});
  final String dataId;
  final String dataImage;
  final Map dataTitles;

  @override
  State<SearchItemScreen> createState() => SearchItemScreenState();
}

class SearchItemScreenState extends State<SearchItemScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: screenSize.width,
          child: Center(
            child: SizedBox(
              width: screenSize.width <= Mobile.minScreenWidth ? 450.0 : 750.0,
              child: Column(
                children: [
                  ItemDetails(dataImage: widget.dataImage, dataTitles: widget.dataTitles,),
                  const SizedBox(height: 20.0),
                  ItemThemes(dataId: widget.dataId)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}