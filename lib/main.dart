import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ukknwskcpchrhiktsldt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVra253c2tjcGNocmhpa3RzbGR0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA5MzgyNTcsImV4cCI6MjA4NjUxNDI1N30.B3MCF4qvctEjpXpiGkvK7fUzo1tYbPhMzXpG0W1R9AE',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
