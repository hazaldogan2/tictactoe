import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'name_entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ltfxmvostfmhhmysepmg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0Znhtdm9zdGZtaGhteXNlcG1nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM3MjA2MTQsImV4cCI6MjAzOTI5NjYxNH0.9bubAOL1vRbh7RNu0lKEqA3QQeLS9NUIMRkDJlmq6HU',
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserNameScreen(),
    );
  }
}



