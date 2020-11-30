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
  int inputNumber = -1;

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
              HintMessage(toBeGuessed, inputNumber),
              TextField(
                controller: textEditController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Type a number'),
              ),
              Center(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      final String value = textEditController.value.text;
                      if (isNumeric(value)) {
                        inputNumber = int.tryParse(value);
                      }
                    });
                  },
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
    if (desiredNumber == -1 || guessedNumber == -1) {
      return '';
    }
    if (desiredNumber < guessedNumber) {
      return 'Enter a smaller number. You entered $guessedNumber';
    } else if (desiredNumber > guessedNumber) {
      return 'Enter a bigger number. You entered $guessedNumber';
    } else if (desiredNumber == guessedNumber) {
      showAlert(context);
      return 'You got it!. The number was $guessedNumber';
    } else {
      return '';
    }
  }

  void showAlert(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('You got it!'),
              content: Text('The number was $desiredNumber'),
            ));
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
