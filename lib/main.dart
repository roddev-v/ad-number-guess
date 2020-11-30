import 'package:flutter/material.dart';
import 'package:number_guessing/guessing_card.dart';

void main() => runApp(NumberGuessing());

class NumberGuessing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Guess the numbe'),
          centerTitle: true,
        ),
        body: BodyContainer(),
      ),
    );
  }
}

class BodyContainer extends StatelessWidget {
  final Widget greetingWidget = const Text(
    'Try to guess the number!',
    style: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
  );

  final Widget gameRulesWidget = const Text(
    'I am thinking of a number between 1 and 100',
    style: TextStyle(fontSize: 18.9),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            greetingWidget,
            gameRulesWidget,
            GuessingCard()
          ],
        ),
      ),
    );
  }
}
