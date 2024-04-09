import 'package:effecient/Providers/chData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Consumer<chDataProvider>(builder: (context, dataProvider, child) {
          return ListView(
            children: dataProvider.favStationList
                .map((item) => ListTile(
                      title: Text(item),
                    ))
                .toList(),
          );
        })
      ],
    ));
  }
}
