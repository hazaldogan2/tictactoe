import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'game_create_screen.dart';
import 'game_screen.dart';

class ListOfGamesScreen extends StatefulWidget {
  @override
  _ListOfGamesScreenState createState() => _ListOfGamesScreenState();
}

class _ListOfGamesScreenState extends State<ListOfGamesScreen> {
  final _gamesSubscription = Supabase.instance.client
      .from('games')
      .any(SupabaseEventTypes.insert, (payload) {
    // Handle new game added
  })
      .on(SupabaseEventTypes.update, (payload) {
    // Handle game updated
  })
      .subscribe();

  @override
  void initState() {
    super.initState();
    Supabase.instance.client
        .from('games')
        .on(SupabaseEventTypes.all, (payload) {
      setState(() {});
    })
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Games')),
      body: FutureBuilder<List<dynamic>>(
        future: Supabase.instance.client.from('games').select(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No games available'));
          } else {
            final games = snapshot.data!;
            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return ListTile(
                  title: Text(game['name']),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(gameId: game['id']),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GameCreateScreen()),
          );
        },
      ),
    );
  }
}
