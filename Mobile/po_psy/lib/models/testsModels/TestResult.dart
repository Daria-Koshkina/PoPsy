class TestResult {
  final List<Score> _scores;

  TestResult(this._scores);
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
}