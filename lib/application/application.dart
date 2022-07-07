import 'package:flutter/material.dart';
import 'package:infinity_cached_scroll/ui/screens/home_screen/home_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
