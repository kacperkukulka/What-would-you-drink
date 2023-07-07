import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/models/user.dart';
import 'package:what_would_you_drink/screens/room/coffee_painter.dart';
import 'package:what_would_you_drink/services/user_service.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, required this.brew});

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0,),
        Opacity(
          opacity: brew.isActual ? 1 : 0.4,
          child: StreamBuilder<UserDb>(
            stream: UserService(uid: brew.userId).user, 
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListTile(
                  visualDensity: const VisualDensity(vertical: 4),
                  tileColor: brew.isActual ? dc.colorBg! : dc.colorBg!.withOpacity(0.4),
                  title: Text(snapshot.data!.name),
                  subtitle: Text(brew.description()),
                  trailing: LayoutBuilder(
                    builder: (p0, p1) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomPaint(
                        painter: CoffeePainter(brew.milk, brew.type),
                        size: Size((p1.maxHeight - 16)/2, p1.maxHeight - 16),
                      ),
                    ),
                  ),
                  leading: LayoutBuilder(
                    builder: (p0, p1) => ClipOval(
                      child: SvgPicture.network(
                        'https://api.dicebear.com/6.x/adventurer/svg?seed=${snapshot.data!.pictureId}', 
                        height: p1.maxHeight,
                      )
                    ),
                  ),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                );
              }
              return const ListTile();
            }
          ),
        ),
      ],
    );
  }
}
