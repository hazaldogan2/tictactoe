import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameScreen extends StatefulWidget {
  final String gameId;

  GameScreen({required this.gameId});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final Color _boardColor;
  List<String> _boardState = List.generate(9, (_) => '');

  @override
  void initState() {
    super.initState();
    _fetchGameData();
  }

  Future<void> _fetchGameData() async {
    final response = await Supabase.instance.client
        .from('games')
        .select()
        .eq('id', widget.gameId)
        .single();

    if (response.isNotEmpty) {
      final game = response.values.first;
      setState(() {
        _boardColor = Color(int.parse(game['board_color']));
        _boardState = List<String>.from(game['board_state']);
      });
    }
  }

  Future<void> _makeMove(int index) async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    // Add game logic here, update board state, and check for win conditions
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Screen')),
      body: Container(
        color: _boardColor,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _makeMove(index),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    _boardState[index],
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

