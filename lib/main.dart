import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D&D Manager',
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
      initialRoute: '/',
      routes: {
        //  Schermata login
        '/': (context) => const LoginScreenStub(),

        //  Homepage con menu e storico
        '/home': (context) => const HomeScreenStub(),

        // Lista eventi
        '/events': (context) => const EventsListScreenStub(),

        // Dettaglio evento scelto
        '/lobby': (context) => const EventLobbyScreenStub(),

        // Schermata di gioco (Chat + Stats)
        '/game': (context) => const GameScreen(),
      },
    );
  }
}
// Widget temporanei
class LoginScreenStub extends StatelessWidget {
  const LoginScreenStub({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BENVENUTO ")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              child: const Text("Accedi"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenStub extends StatelessWidget {
  const HomeScreenStub({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Homepage")),
    body: Center(child: 
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Homepage"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/game'),
            child: Text("Vai al Gioco"),
          ),
        ],
      ),
    ),
  );
}

class EventsListScreenStub extends StatelessWidget {
  const EventsListScreenStub({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Eventi")),
    body: Center(child: Text("Eventi")),
  );
}

class EventLobbyScreenStub extends StatelessWidget {
  const EventLobbyScreenStub({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Lobby")),
    body: Center(child: Text("Lobby")),
  );
}
