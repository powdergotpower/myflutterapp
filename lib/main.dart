import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yvnjzzwmiwjepmwmfvca.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl2bmp6endtaXdqZXBtd21mdmNhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA2MjEzOTIsImV4cCI6MjA4NjE5NzM5Mn0.wW5hbLSiWFjCWXoaqQ8-ee54-fGI11NTfS_ldu6YylM',
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
