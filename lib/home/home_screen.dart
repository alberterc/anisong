import 'package:anisong/data/api.dart';
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
                SearchTextField(onContentChanged: (String value) {
                  if (currSearchValue != value) {
                    setState(() {
                      currSearchValue = value;
                    });
                  }
                }),
                const SizedBox(height: 20.0,),
                Flexible(
                  child: SearchResultList(query: currSearchValue),
                )
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
    return FractionallySizedBox(
        widthFactor: 0.7,
        child: FutureBuilder<Map?>(
          future: Anime.getSearchResult(widget.query, '1'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  List data = snapshot.data!.containsKey('data') ? snapshot.data!['data'] : null;
                  // Map pagination = snapshot.data!.containsKey('pagination') ? snapshot.data!['pagination'] : null;
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 5),
                    itemBuilder: (_, index) {
                      Map image = data[index]['images'].containsKey('webp') ? data[index]['images']['webp'] : data[index]['images']['jpg'];
                      Map titles = {
                        'jpTitle': data[index]['title'],
                        'enTitle': data[index]['title_english'] ?? ''
                      };
                      return ThumbnailCard(dataImage: image['image_url'], dataTitles: titles);
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
        ),
      );
  }
}

class ThumbnailCard extends StatelessWidget {
  const ThumbnailCard({super.key, required this.dataImage, required this.dataTitles});
  final String dataImage;
  final Map dataTitles;

  @override
  Widget build(BuildContext context) {
    var width = 300.0;
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: width,
        height: width * 3,
        child: InkWell(
          child: Card(
            elevation: 0,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(dataImage),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dataTitles['jpTitle']),
                      dataTitles['enTitle'] != '' ? Text(dataTitles['enTitle'], style: const TextStyle(color: Color.fromARGB(255, 117, 117, 117)),) : Container()
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}