import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterSection extends StatefulWidget {
  final List<Character> party;

  const CharacterSection({super.key, required this.party});

  @override
  State<CharacterSection> createState() => _CharacterSectionState();
}

class _CharacterSectionState extends State<CharacterSection> {
  late Character _selectedCharacter;
  int _selectedTabIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _selectedCharacter = widget.party.first;
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5E6D3), // Parchment light color
        border: Border.all(color: const Color(0xFF4E342E), width: 4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          // 1. Top Party Selector
          _buildPartySelector(),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                 // Character Name
                 Text(
                    _selectedCharacter.name,
                    style: const TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Character Image Area
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF8D6E63), width: 2),
                      ),
                      child: Center(
                         // In real app, use Image.asset
                         // child: Image.asset(_selectedCharacter.imagePath, fit: BoxFit.cover),
                        child: Icon(Icons.person, size: 80, color: Colors.white54),
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // 2. Action Buttons (Stats, Inventory, Skills) moved below image
                _buildActionButtons(),

                const SizedBox(height: 8),

                // Content PageView
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    children: [
                      _buildMainStatsPage(),
                      _buildInventoryPage(),
                      _buildSkillsPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartySelector() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF3E2723),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.party.map((char) => _buildPartyAvatar(char)).toList(),
      ),
    );
  }

  Widget _buildPartyAvatar(Character char) {
    final isSelected = _selectedCharacter.name == char.name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCharacter = char;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFFFFB74D) : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(char.name[0], style: const TextStyle(color: Colors.white)),
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 30,
              color: const Color(0xFFFFB74D), // Underline
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.shield, "Stats", 0),
        _buildActionButton(Icons.backpack, "Inventory", 1),
        _buildActionButton(Icons.auto_stories, "Skills", 2),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Column(
        children: [
          Container(
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
               color: isSelected ? const Color(0xFF8D6E63) : const Color(0xFFA1887F),
               shape: BoxShape.circle,
               border: Border.all(color: const Color(0xFF3E2723), width: 2),
               boxShadow: [
                 if (isSelected) BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2,2))
               ]
             ),
             child: Icon(icon, color: const Color(0xFFF5E6D3), size: 28),
          ),
          // const SizedBox(height: 4),
          // Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3E2723))),
        ],
      ),
    );
  }

  Widget _buildMainStatsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
           // HP & Level Row
          _buildStatusRow(_selectedCharacter),
          
          const SizedBox(height: 16),
          
          // Stats Grid
          _buildStatsGrid(_selectedCharacter),
        ],
      ),
    );
  }

  Widget _buildInventoryPage() {
    return const Center(child: Text("Inventario (In costruzione)", style: TextStyle(fontSize: 18, color: Color(0xFF5D4037))));
  }

  Widget _buildSkillsPage() {
    return const Center(child: Text("Abilità & Incantesimi (In costruzione)", style: TextStyle(fontSize: 18, color: Color(0xFF5D4037))));
  }

  Widget _buildStatusRow(Character char) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // HP
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("HP ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF3E2723))),
                  Text("${char.currentHp}/${char.maxHp}", style: const TextStyle(fontSize: 18, color: Color(0xFF3E2723))),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: char.currentHp / char.maxHp,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Level
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Level ${char.level} ${char.charClass}", style: const TextStyle(fontSize: 16, color: Color(0xFF3E2723))),
               ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: char.currentXp / char.maxXp,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(Character char) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: char.abilityScores.length,
      itemBuilder: (context, index) {
        final stat = char.abilityScores[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFA1887F)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stat.name,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4E342E)),
              ),
              Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${stat.value}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3E2723)),
                  ),
                   Text(
                    stat.modifierString,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
