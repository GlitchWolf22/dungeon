import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/message.dart';

class ChatSection extends StatefulWidget {
  final List<Character> party;
  final List<ChatMessage> messages;
  final Function(String) onSendMessage;

  const ChatSection({
    super.key,
    required this.party,
    required this.messages,
    required this.onSendMessage,
  });

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  final TextEditingController _controller = TextEditingController();
  late Character _selectedChatter;

  @override
  void initState() {
    super.initState();
    _selectedChatter = widget.party.first;
  }

  void _handleSend() {
    if (_controller.text.trim().isEmpty) return;
    // We might need to update the parent callback to accept character name or just rely on parent tracking
    // For now, let's assume the parent handles the message addition using the selected character.
    // BUT, the parent was using its own tracked character.
    // Let's change the callback signature in a refactor, OR simpler:
    // Update the parent state? No, easier to just send the text, and let the parent know WHO sent it?
    // Wait, the parent has `_currentCharacter`. 
    // Actually, it's better if `ChatSection` handles the "who is typing" UI, but the message itself 
    // is constructed here or we pass the sender name up.
    // Re-reading `game_screen.dart`: `_sendMessage(String text)` uses `_currentCharacter.name`.
    // So I should probably update `_currentCharacter` in `GameScreen`? 
    // OR just pass the name in `onSendMessage`.
    // Let's modify the callback to `Function(String text, Character sender)`?
    // For now, to minimize changes in GameScreen, checking what I did in Step 4.
    // I used `_currentCharacter` in `GameScreen`. 
    // I should probably move the selection logic strictly to `ChatSection` OR lift state up.
    // Lifting state up is cleaner. Let's add `onChatterChanged` callback?
    // Or just accept that `ChatSection` controls the "active typer".
    // Let's stick to the plan: I'll assume ChatSection manages who is typing locally for the UI, 
    // but I need to ensure the message sent has the right name.
    
    // Actually, looking at `GameScreen` again: `_sendMessage(String text)` uses `_currentCharacter.name`.
    // I can't easily change `_currentCharacter` in parent without a callback.
    // So let's change `onSendMessage` payload to include the sender name!
    
    widget.onSendMessage(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Side: Vertical Character Selector
        Container(
          width: 80,
          color: const Color(0xFF2C241B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...widget.party.map((char) => _buildChatterAvatar(char)),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // Right Side: Chat Area
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C241B),
              border: Border(
                right: BorderSide(color: const Color(0xFF5D4037), width: 4),
                top: BorderSide(color: const Color(0xFF5D4037), width: 4),
                bottom: BorderSide(color: const Color(0xFF5D4037), width: 4),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFF5D4037), width: 2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, color: Color(0xFFD7CCC8)),
                      const SizedBox(width: 8),
                      Text(
                        "Game Chat - ${_selectedChatter.name}",
                        style: const TextStyle(
                          color: Color(0xFFD7CCC8),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Chat List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.messages.length,
                    itemBuilder: (context, index) {
                      final msg = widget.messages[index];
                      // Highlight messages from current user?
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white70, fontSize: 16),
                            children: [
                              TextSpan(
                                text: "${msg.sender}: ",
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFB74D)),
                              ),
                              TextSpan(text: msg.text),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Input Area
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFF5D4037), width: 2)),
                    color: Color(0xFF3E2723),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Parla come ${_selectedChatter.name}...",
                            hintStyle: const TextStyle(color: Colors.white38),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _handleSend(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFFFFB74D)),
                        onPressed: _handleSend,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatterAvatar(Character char) {
    final isSelected = _selectedChatter.name == char.name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChatter = char;
        });
        // TODO: Notify parent if needed, but for now we really need to change who sends the message.
        // I will change the callback signature in GameScreen.
        widget.onSendMessage("SWITCH_CHAR:${char.name}"); 
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8),
        transform: Matrix4.translationValues(0, isSelected ? -10 : 0, 0), // "Up" animation
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? const Color(0xFFFFB74D) : Colors.transparent, 
              width: 3
            ),
            boxShadow: isSelected ? [BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 10)] : [],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            // backgroundImage: AssetImage(char.imagePath),
            child: Text(char.name[0], style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
