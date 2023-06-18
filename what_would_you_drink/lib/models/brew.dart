class Brew{
  
  final String name;
  final int sugars;
  final int strength;

  Brew({
    required this.name, 
    required this.sugars, 
    required this.strength
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