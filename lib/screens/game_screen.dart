import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/message.dart';
import '../widgets/chat_section.dart';
import '../widgets/character_section.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Dummy data
  final List<Character> _party = Character.dummyParty();
  final List<ChatMessage> _messages = [
    ChatMessage.system("Benvenuto in Dungeon!"),
    ChatMessage.gm("Ti trovi in una stanza buia. Una debole luce filtra da una crepa nel soffitto."),
    ChatMessage.player("Dorian", "Accendo la torcia."),
  ];

  late Character _currentCharacter;

  @override
  void initState() {
    super.initState();
    _currentCharacter = _party.first;
  }

  void _sendMessage(String text) {
    if (text.startsWith("SWITCH_CHAR:")) {
      final newCharName = text.split(":")[1];
      setState(() {
        _currentCharacter = _party.firstWhere((c) => c.name == newCharName, orElse: () => _currentCharacter);
      });
      return;
    }

    setState(() {
      _messages.add(ChatMessage.player(_currentCharacter.name, text));
      
      // Simulate GM response
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage.gm("La voce di ${_currentCharacter.name} echeggia nella stanza..."));
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background for the whole screen
      body: Row(
        children: [
          // Left Side: Chat (Flex 2/3)
          Expanded(
            flex: 2,
            child: ChatSection(
              party: _party,
              messages: _messages,
              onSendMessage: _sendMessage,
            ),
          ),
          
          // Right Side: Character Sheet (Flex 1/3)
          Expanded(
            flex: 1,
            child: CharacterSection(party: _party),
          ),
        ],
      ),
    );
  }
}
