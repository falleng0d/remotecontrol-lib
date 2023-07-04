/// This is a scratch file for testing code snippets.

/// Class hierarchy rules
///

abstract class LivingThing {
  const LivingThing();
}

abstract class Animal extends LivingThing {
  String get name;

  const Animal(String name);
}

class Dog extends Animal {
  final String _name;

  @override
  String get name => _name;

  const Dog(this._name) : super(_name);
}

abstract class Plant extends LivingThing {
  String get species;

  const Plant(String species);
}

abstract class Tree extends Plant {
  const Tree(String species) : super(species);
}

class Palm extends Tree {
  final String _species;

  @override
  String get species => _species;

  const Palm(this._species) : super(_species);
}

abstract class Forest {
  List<Plant> get plants;

  const Forest(List<Plant> plants);

  void addPlant(covariant Plant plant);
}

class PalmForest extends Forest {
  final List<Palm> _plants;

  @override
  List<Palm> get plants => _plants;

  const PalmForest(this._plants) : super(_plants);

  @override
  void addPlant(LivingThing plant) {
    // _plants.add(plant);
    if (Plant is Palm) {
      _plants.add(plant as Palm);
    }
  }
}

void main() {
  final forest = PalmForest([Palm('Palm 1'), Palm('Palm 2')]);
  print(forest.plants);

  final dog = Dog('Dog 1');

  print(dog.name);

  // This should not be allowed!!!
  forest.addPlant(dog);
}
