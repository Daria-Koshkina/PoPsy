class AnswerScores {
  final List<Score> _scores;

  AnswerScores(this._scores);

  factory AnswerScores.fromJson(Map<String, dynamic> json){
    return AnswerScores(
      json['score'].map<Score>((json) => Score.fromJson(json)).toList(),
    );
  }

  String getResult(double value) {
    for (int i = 0; i < _scores.length; i++){
      if (value >= _scores[i].start && value <= _scores[i].end) {
        return _scores[i].text;
      }
    }
    return 'Wrong result';
  }
}

class Score {
  final double start;
  final double end;
  final String text;

  Score(this.start, this.end, this.text);

  factory Score.fromJson(Map<String, dynamic> json){
    return Score(
      json['start'],
      json['end'],
      json['text'],
    );
  }
}