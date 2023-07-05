import 'room.dart';
import 'brew.dart';

class UserDb{
  final String name;
  final int pictureId;
  final List<Room>? homes;
  final List<Brew>? brews;

  UserDb({
    required this.name,
    required this.pictureId,
    this.homes,
    this.brews
  });
}

const int picMaxNum = 99999999;
