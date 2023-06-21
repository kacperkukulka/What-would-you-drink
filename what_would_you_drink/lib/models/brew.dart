class Brew{
  final String type;
  final int sugars;
  final int strength;
  final bool isActual;
  final String userId;
  final String? roomId;

  Brew({
    required this.type, 
    required this.sugars, 
    required this.strength,
    required this.isActual,
    required this.userId,
    required this.roomId
  });

  String sugarStringPL(){
    late String spoon;
    switch (sugars%10) {
      case 0: case 5: case 6: case 7: case 8: case 9:
        spoon = 'łyżeczek';
        break;
      case 1: 
        spoon = 'łyżeczka';
        break;
      default:
        spoon = 'łyżeczki';
        break;
    }
    return "$sugars $spoon cukru";
  }
}