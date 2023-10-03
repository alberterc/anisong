import 'package:anisong/utility.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.dataImage, required this.dataTitles});
  final String dataImage;
  final Map dataTitles;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Card(
      color: const Color.fromARGB(255, 40, 40, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.all(20.0), 
        child: screenSize.width <= Mobile.minScreenWidth ? 
          MobileView(dataImage: dataImage, dataTitles: dataTitles) :
          DekstopView(dataImage: dataImage, dataTitles: dataTitles)
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({super.key, required this.dataImage, required this.dataTitles});
  final String dataImage;
  final Map dataTitles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(dataImage),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                dataTitles['jpTitle'],
                style: TextStyle(
                  fontSize: Mobile.fontSize + fontSizeLargerOffset
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: true,
              ),
              dataTitles['jpTitle'] != dataTitles['enTitle'] ?
                Text(
                  dataTitles['enTitle'],
                  style: TextStyle(
                    fontSize: Mobile.fontSize,
                    color: const Color.fromARGB(255, 107, 107, 107)
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: true,
                ) :
                const SizedBox()
            ],
          ),
        )
      ],
    );
  }
}

class DekstopView extends StatelessWidget {
  const DekstopView({super.key, required this.dataImage, required this.dataTitles});
  final String dataImage;
  final Map dataTitles;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(dataImage),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  dataTitles['jpTitle'],
                  style: TextStyle(
                    fontSize: Dekstop.fontSize + fontSizeLargerOffset
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: true,
                ),
                dataTitles['jpTitle'] != dataTitles['enTitle'] ?
                  Text(
                    dataTitles['enTitle'],
                    style: TextStyle(
                      fontSize: Dekstop.fontSize,
                      color: const Color.fromARGB(255, 107, 107, 107)
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                  ) :
                  const SizedBox()
              ],
            ),
          )
        )
      ],
    );
  }
}