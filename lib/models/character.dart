import 'package:flutter/foundation.dart';

class AbilityScore {
  final String name;
  final int value;

  AbilityScore({required this.name, required this.value});

  int get modifier => (value - 10) ~/ 2;
  
  String get modifierString => modifier >= 0 ? '+$modifier' : '$modifier';
}

class Character {
  final String name;
  final String charClass;
  final int level;
  final String imagePath;
  final int currentHp;
  final int maxHp;
  final int currentXp; // progress bar
  final int maxXp; // progress bar

  final List<AbilityScore> abilityScores;

  Character({
    required this.name,
    required this.charClass,
    required this.level,
    required this.imagePath,
    required this.currentHp,
    required this.maxHp,
    required this.currentXp,
    required this.maxXp,
    required this.abilityScores,
  });

  // Factory for a dummy character
  factory Character.dummy() {
    return Character(
      name: "Dorian the Brave",
      charClass: "Warrior",
      level: 2,
      imagePath: "assets/images/warrior.png", // Placeholder
      currentHp: 26,
      maxHp: 36,
      currentXp: 450,
      maxXp: 1000,
      abilityScores: [
        AbilityScore(name: "Strength", value: 16),
        AbilityScore(name: "Dexterity", value: 14),
        AbilityScore(name: "Constitution", value: 14),
        AbilityScore(name: "Intelligence", value: 10),
        AbilityScore(name: "Wisdom", value: 12),
        AbilityScore(name: "Charisma", value: 11),
      ],
    );
  }

  static List<Character> dummyParty() {
    return [
      Character(
        name: "Dorian",
        charClass: "Warrior",
        level: 2,
        imagePath: "assets/images/warrior.png",
        currentHp: 26,
        maxHp: 36,
        currentXp: 450,
        maxXp: 1000,
        abilityScores: [
          AbilityScore(name: "Strength", value: 16),
          AbilityScore(name: "Dexterity", value: 14),
          AbilityScore(name: "Constitution", value: 14),
          AbilityScore(name: "Intelligence", value: 10),
          AbilityScore(name: "Wisdom", value: 12),
          AbilityScore(name: "Charisma", value: 11),
        ],
      ),
      Character(
        name: "Elara",
        charClass: "Mage",
        level: 2,
        imagePath: "assets/images/mage.png",
        currentHp: 18,
        maxHp: 24,
        currentXp: 450,
        maxXp: 1000,
        abilityScores: [
          AbilityScore(name: "Strength", value: 8),
          AbilityScore(name: "Dexterity", value: 12),
          AbilityScore(name: "Constitution", value: 10),
          AbilityScore(name: "Intelligence", value: 18),
          AbilityScore(name: "Wisdom", value: 14),
          AbilityScore(name: "Charisma", value: 13),
        ],
      ),
      Character(
         name: "Thorne",
        charClass: "Rogue",
        level: 2,
        imagePath: "assets/images/rogue.png",
        currentHp: 22,
        maxHp: 30,
        currentXp: 450,
        maxXp: 1000,
        abilityScores: [
          AbilityScore(name: "Strength", value: 10),
          AbilityScore(name: "Dexterity", value: 18),
          AbilityScore(name: "Constitution", value: 12),
          AbilityScore(name: "Intelligence", value: 14),
          AbilityScore(name: "Wisdom", value: 10),
          AbilityScore(name: "Charisma", value: 15),
        ],
      ),
      Character(
        name: "Lyra",
        charClass: "Cleric",
        level: 2,
        imagePath: "assets/images/cleric.png",
        currentHp: 24,
        maxHp: 32,
        currentXp: 450,
        maxXp: 1000,
        abilityScores: [
          AbilityScore(name: "Strength", value: 12),
          AbilityScore(name: "Dexterity", value: 10),
          AbilityScore(name: "Constitution", value: 14),
          AbilityScore(name: "Intelligence", value: 12),
          AbilityScore(name: "Wisdom", value: 16),
          AbilityScore(name: "Charisma", value: 14),
        ],
      ),
    ];
  }
}
