import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'game_list_screen.dart';

class UserNameScreen extends StatefulWidget {
  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final _nameController = TextEditingController();

  Future<void> _submitName() async {
    final name = _nameController.text;
    if (name.isEmpty) return;

    final response = await Supabase.instance.client
        .from('users')
        .insert({'name': name});

    if (response.error == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListOfGamesScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Your Name')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submitName, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}

