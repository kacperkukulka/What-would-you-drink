class Brew{
  final String type;
  final int sugars;
  final int strength;
  final bool isActual;
  final int milk;
  final String userId;
  final String? roomId;

  Brew({
    required this.type, 
    required this.sugars, 
    required this.strength,
    required this.isActual,
    required this.milk,
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

  String description(){
    late String description;
    switch (type) {
      case 'tea': description = "Herbata"; break;
      case 'coffee': description = "Kawa(dowolna)"; break;
      case 'loose_coffee': description = "Kawa sypana"; break;
      case 'instant_coffee': description = "Kawa rozpuszczalna"; break;
      default: description = "Błąd"; break;
    }

    description += ", $milk% mleka, ${sugarStringPL()}";
    
    return description;
  }
}