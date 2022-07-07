import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({
    Key? key,
    required this.endOfStory,
  }) : super(key: key);

  final bool endOfStory;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: endOfStory
          ? const Text(
              'end of story :(',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          : const SizedBox(
              height: 24.0,
              width: 24.0,
              child: CircularProgressIndicator(strokeWidth: 1.5),
            ),
    );
  }
}
