import 'package:flutter/material.dart';

import 'homepage.dart';

class StarterScreen extends StatelessWidget{
  const StarterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (
          TextButton(
              child: const Text('Start'),
              onPressed: () {
                _navigateToNextScreen(context);
              }
          )

      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
