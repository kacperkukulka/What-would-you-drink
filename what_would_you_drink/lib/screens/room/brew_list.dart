import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
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
    brews.sort((a,b){
      if(a.isActual && !b.isActual) { return -1; }
      else { return 1; }
    });

    return brews.isEmpty ? const Loading() : ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: brews.length,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      itemBuilder: (context, index){
        try{
          if(brews[index].isActual == false && brews[index-1].isActual == true){
            return Column(
              children: [
                const SizedBox(height: 20.0),
                BrewTile(brew: brews[index])
              ],
            );
          }
        } catch(_){}
        return BrewTile(brew: brews[index]);
      }
    );
  }
}