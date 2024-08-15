import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameCreateScreen extends StatefulWidget {
  @override
  _GameCreateScreenState createState() => _GameCreateScreenState();
}

class _GameCreateScreenState extends State<GameCreateScreen> {
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();

  Future<void> _createGame() async {
    final gameName = _nameController.text;
    final boardColor = _colorController.text;

    if (gameName.isEmpty || boardColor.isEmpty) return;

    final userId = Supabase.instance.client.auth.currentUser!.id;

    final response = await Supabase.instance.client
        .from('games')
        .insert({
      'name': gameName,
      'board_color': boardColor,
      'player1_id': userId,
      'board_state': List.generate(9, (_) => ''),
      'status': 'ongoing'
    });

    if (response.error == null) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create a Game')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Game Name')),
            TextField(controller: _colorController, decoration: InputDecoration(labelText: 'Board Color')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _createGame, child: Text('Create Game')),
          ],
        ),
      ),
    );
  }
}

