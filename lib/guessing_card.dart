import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_guessing/utils.dart';

class GuessingCard extends StatefulWidget {
  @override
  _GuessingCardState createState() => _GuessingCardState();
}

class _GuessingCardState extends State<GuessingCard> {
  final TextEditingController textEditController = TextEditingController();
  int toBeGuessed = Random().nextInt(100);
  int inputNumber;

  int lives = 5;

  void showAlert(BuildContext context, String title, String message) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        lives = 5;
                        toBeGuessed = Random().nextInt(100);
                        inputNumber = null;
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text(
                      'Try again',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }

  void updateState() {
    setState(() {
      final String value = textEditController.value.text;
      if (isNumeric(value)) {
        inputNumber = int.tryParse(value);
        textEditController.clear();
        lives--;
        if (lives == 0) {
          showAlert(context, 'Ooops....',
              'The number was $toBeGuessed. Don\'t quit already');
        }
        if (inputNumber == toBeGuessed) {
          showAlert(context, 'You got it', 'The number was $toBeGuessed');
        }
      }
    });
  }

  Color getColor() {
    return lives > 3 ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You have $lives left',
                style: TextStyle(color: getColor()),
              ),
              HintMessage(toBeGuessed, inputNumber),
              TextField(
                controller: textEditController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Type a number'),
              ),
              Center(
                child: FlatButton(
                  onPressed: () => updateState(),
                  child: const Text('Guess'),
                  color: Colors.black12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HintMessage extends StatelessWidget {
  HintMessage(this.desiredNumber, this.guessedNumber) {
    print(desiredNumber);
    print(guessedNumber);
  }

  int desiredNumber = -1;
  int guessedNumber = -1;

  String getMessage(BuildContext context) {
    if (guessedNumber == null) {
      return '';
    }
    if (desiredNumber < guessedNumber) {
      return 'Enter a smaller number. You entered $guessedNumber';
    } else if (desiredNumber > guessedNumber) {
      return 'Enter a bigger number. You entered $guessedNumber';
    } else if (desiredNumber == guessedNumber) {
      return 'You got it!. The number was $guessedNumber';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getMessage(context),
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
