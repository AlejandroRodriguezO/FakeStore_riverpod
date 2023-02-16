import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/pages/controller/home_state.dart';

import 'pages/home_page.dart';
import 'provider/provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final dark = ref.watch(darkMode);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store riverpod',
        theme: ThemeData(
          brightness: dark ? Brightness.dark : Brightness.light,
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
    });
  }
}
