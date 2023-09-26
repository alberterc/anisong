import 'package:anisong/data/api.dart';
import 'package:anisong/searchTheme/search_theme_screen.dart';
import 'package:anisong/utility.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String currSearchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0,),
                SearchTextField(onContentChanged: (String value) {
                  if (currSearchValue != value) {
                    setState(() {
                      currSearchValue = value;
                    });
                  }
                }),
                const SizedBox(height: 20.0,),
                Flexible(child: SearchResultList(query: currSearchValue)),
              ],
            ),
        ),
      );
  }
}


class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.onContentChanged});
  final ValueChanged<String> onContentChanged;

  void pushSearchString(String string, BuildContext context) {
    onContentChanged(string.trim().toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: TextField(
        onSubmitted: (value) => pushSearchString(value, context),
        autocorrect: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            hintText: 'Search by anime title here...'
          ),
        ),
    );
  }
}

class SearchResultList extends StatefulWidget {
  const SearchResultList({super.key, required this.query});
  final String query;

  @override
  State<SearchResultList> createState() => SearchResultListState();
}
class SearchResultListState extends State<SearchResultList> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var cardSize = screenSize.width <= Mobile.minScreenWidth ? {'height': 215.0, 'width': 125.0} : {'height': 315.0, 'width': 225.0};
    return FutureBuilder<Map?>(
      future: Anime.getSearchResult(widget.query, '1'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              List data = snapshot.data!.containsKey('data') ? snapshot.data!['data'] : null;
              // Map pagination = snapshot.data!.containsKey('pagination') ? snapshot.data!['pagination'] : null;
              return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: data.length,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                gridDelegate: screenSize.width <= Mobile.minScreenWidth ? 
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 5, childAspectRatio: Mobile.childAspectRatio) : 
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 5, childAspectRatio: Dekstop.childAspectRatio),
                itemBuilder: (_, index) {
                  Map image = data[index]['images'].containsKey('webp') ? data[index]['images']['webp'] : data[index]['images']['jpg'];
                  Map titles = {
                    'jpTitle': data[index]['title'],
                    'enTitle': data[index]['title_english'] ?? ''
                  };
                  String id = data[index]['mal_id'].toString();
                  return Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: cardSize['height']!,
                      width: cardSize['width']!,
                      child: ThumbnailCard(dataId: id, dataImage: image['image_url'], dataTitles: titles),
                    ),
                  );
                },
              );
            }
            else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Result'),
              );
            }
          }
        }
        else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ThumbnailCard extends StatelessWidget {
  const ThumbnailCard({super.key, required this.dataId, required this.dataImage, required this.dataTitles});
  final String dataId;
  final String dataImage;
  final Map dataTitles;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Ink.image(
        image: NetworkImage(dataImage),
        fit: BoxFit.cover,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchThemeScreen(dataId: dataId)));
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    stops: const [0, 1],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter
                  )
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10
                ),
                child: 
                  screenSize.width <= Mobile.minScreenWidth ? 
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataTitles['jpTitle'],
                            style: TextStyle(
                              fontSize: Mobile.fontSize
                            )
                          ),
                        ],
                      ),
                    ) :
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataTitles['jpTitle'],
                            style: TextStyle(
                              fontSize: Dekstop.fontSize
                            )
                          ),
                        ],
                      ),
                    ),
              )
            ],
          ),
        ), 
      )
    );
  }
}