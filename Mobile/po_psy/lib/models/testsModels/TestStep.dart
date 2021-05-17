class TestStep {
  final Question question;
  final List<Answer> answers;
  final String imageURL;

  TestStep(this.question, this.answers, this.imageURL);

  factory TestStep.fromJson(Map<String, dynamic> json){
    return TestStep(
        Question.fromJson(json['text']),
        json['variants'].map<Answer>((json) => Answer.fromJson(json)).toList(),
        json['photo']
    );
  }
}

class Question {
  final String text;
  Question(this.text);
  factory Question.fromJson(String json){
    return Question(
        json
    );
  }
}

class Answer {
  final String text;
  final double weight;

  Answer(this.text, this.weight,);

  factory Answer.fromJson(Map<String, dynamic> json){
    return Answer(
        json['text'],
        json['weight']
    );
  }
}