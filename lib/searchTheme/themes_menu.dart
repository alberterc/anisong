import 'package:flutter/material.dart';
import 'package:anisong/utility.dart';
import 'package:anisong/data/api.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ThemesMenu extends StatefulWidget {
  const ThemesMenu({super.key, required this.dataId});
  final String dataId;

  @override
  State<ThemesMenu> createState() =>  ThemesMenuState();
}

class ThemesMenuState extends State<ThemesMenu> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<Map?>(
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
            return Column(
              children: [
                ExpansionTile(
                  title: screenSize.width <= Mobile.minScreenWidth ?
                    Text('Openings', style: TextStyle(fontSize: Mobile.fontSize + fontSizeLargerOffset),) :
                    Text('Openings', style: TextStyle(fontSize: Dekstop.fontSize),),
                  initiallyExpanded: false,
                  children: [
                    SizedBox(
                      height: 250,
                      child: SearchThemeItem(itemList: openings),
                    )
                  ],
                ),
                ExpansionTile(
                  title: screenSize.width <= Mobile.minScreenWidth ?
                    Text('Endings', style: TextStyle(fontSize: Mobile.fontSize + fontSizeLargerOffset),) :
                    Text('Endings', style: TextStyle(fontSize: Dekstop.fontSize),),
                  initiallyExpanded: false,
                  children: [
                    SizedBox(
                      height: 250,
                      child: SearchThemeItem(itemList: endings),
                    )
                  ],
                )
              ],
            );
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

class SearchThemeItem extends StatelessWidget {
  const SearchThemeItem({super.key, required this.itemList});
  final List itemList;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final title = itemList[index].lastIndexOf('(') != -1 ? 
            itemList[index].substring(0, itemList[index].lastIndexOf('(')).trim() :
            itemList[index];
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 10
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
                Flexible(
                  child: screenSize.width <= Mobile.minScreenWidth ?
                    Text(
                      itemList[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: Mobile.fontSize
                      ),
                    ) :
                    Text(
                      itemList[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: Dekstop.fontSize - fontSizeLargerOffset
                      ),
                    )
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.content_copy_rounded),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: title)).then((_) => 
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Title copied to clipboard.'))
                          )
                        );
                      },
                    ),
                    LaunchUrlIconButton(
                      icon: const Icon(Icons.ondemand_video_rounded),
                      url: '${CommonUrl.youtube}/results?search_query=$title'
                    )
                  ],
                )
              ]
            ),
          );
        },
      );
  }
}

class LaunchUrlIconButton extends StatelessWidget {
  const LaunchUrlIconButton({super.key, required this.icon, required this.url});
  final Icon icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
        else {
          throw 'Failed to open $url';
        }
      },
    );
  }
}