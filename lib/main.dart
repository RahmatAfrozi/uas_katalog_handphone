import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/phone_provider.dart';
import 'screens/home_screen.dart';
import 'screens/phone_list_screen.dart';
import 'screens/phone_form_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PhoneProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Handphone',

      // THEME (BISA DIKEMBANGKAN KE DARK MODE)
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),

      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/list': (context) => const PhoneListScreen(),
        '/form': (context) => const PhoneFormScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
