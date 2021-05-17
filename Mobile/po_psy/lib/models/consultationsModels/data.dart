import 'package:po_psy/models/consultationsModels/Psychologist.dart';

class PsychologistsData {
  var psy1 = Psychologist('Smith Alex', 33, 'The best psychologist', 'alex@.com', '@alexsmaith', 'https://picsum.photos/250?image=9');
  List<Psychologist> getPsychologists() {
    List<Psychologist> list = [
      psy1,
      psy1,
      psy1,
      psy1
    ];
    return list;
  }
}