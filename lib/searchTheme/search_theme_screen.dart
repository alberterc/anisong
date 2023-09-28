import 'package:anisong/utility.dart';
import 'package:flutter/material.dart';
import 'package:anisong/data/api.dart';
import 'package:flutter/services.dart';

class SearchThemeScreen extends StatefulWidget {
  const SearchThemeScreen({super.key, required this.dataId});
  final String dataId;

  @override
  State<SearchThemeScreen> createState() => SearchThemeScreenState();
}

class SearchThemeScreenState extends State<SearchThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder<Map?>(
              future: Anime.getThemes(widget.dataId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List openings = snapshot.data!['openings'].length > 0 ? snapshot.data!['openings'] : [];
                    List endings = snapshot.data!['endings'].length > 0 ? snapshot.data!['endings'] : [];
                    for (int i = 0; i < openings.length; i++) {
                      if (openings[i].substring(1, 2).contains(':')) {
                        openings[i] = openings[i].substring(3).trim();
                      }
                    }
                    for (int i = 0; i < endings.length; i++) {
                      if (endings[i].substring(1, 2).contains(':')) {
                        endings[i] = endings[i].substring(3).trim();
                      }
                    }
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Openings', style: TextStyle(fontSize: Dekstop.fontSize + 4.0),),
                          const SizedBox(height: 10.0,),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: openings.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10
                                ),
                                margin: const EdgeInsets.only(
                                  bottom: 10.0
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 61, 61, 61)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      openings[index]
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: openings[index])).then((_) => 
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Title copied to clipboard.'))
                                          )
                                        );
                                      },
                                      child: const Text('Copy Title'),
                                    )
                                  ]
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          const Text('Endings'),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: openings.length,
                            itemBuilder: (context, index) {
                              return Text(
                                endings[index]
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                }
                else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      )
    );
  }
}
