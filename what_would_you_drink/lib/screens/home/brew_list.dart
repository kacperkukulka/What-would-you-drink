import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context);
    
    return ListView.builder(
      itemCount: brews.length,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      itemBuilder: (context, index){
        return BrewTile(brew: brews[index]);
      }
    );
  }
}