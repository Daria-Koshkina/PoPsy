class TestStep {
  final Question question;
  final List<Answer> answers;

  TestStep(this.question, this.answers);
}

class Question {
  final String text;
  Question(this.text);
}

class Answer {
  final String text;
  final double weight;

  Answer(this.text, this.weight,);
}