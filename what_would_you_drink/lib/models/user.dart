import 'room.dart';
import 'brew.dart';

class UserDb{
  final String name;
  final List<Room>? homes;
  final List<Brew>? brews;

  UserDb({
    required this.name,
    this.homes,
    this.brews
  });
}