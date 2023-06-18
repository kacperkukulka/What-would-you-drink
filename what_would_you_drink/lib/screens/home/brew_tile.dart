import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, required this.brew});

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0,),
        ListTile(
          tileColor: dc.colorBg,
          title: Text(brew.name),
          subtitle: Text(brew.sugarStringPL()),
          leading: CircleAvatar(
            backgroundColor: Colors.brown[brew.strength],
          ),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ],
    );
  }
}
