class TestStep {
  final Question question;
  final List<Answer> answers;
  final String imageURL;

  TestStep(this.question, this.answers, this.imageURL);
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