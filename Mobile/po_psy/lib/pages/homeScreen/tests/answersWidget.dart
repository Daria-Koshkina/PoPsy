import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:po_psy/models/testsModels/TestStep.dart';

class AnswersWidget extends StatefulWidget {
  final List<Answer> _answers;

  const AnswersWidget(this._answers);
  @override
  _AnswersWidgetState createState() => _AnswersWidgetState();
}

class _AnswersWidgetState extends State<AnswersWidget> {
  List<String> _checked = [];

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CheckboxGroup(
            labels: _getAnswersTitles(widget._answers),
            onSelected: (List<String> checked) => print(checked.toString())
        )
    );;
  }
}

List<String> _getAnswersTitles(List<Answer> answers) {
  var titles = <String>[];
  for (int i = 0; i < answers.length; i++) {
    titles.add(answers[i].text);
  }
  return titles;
}