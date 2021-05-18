import 'package:po_psy/models/consultationsModels/Psychologist.dart';

class PsychologistsData {
  var psy1 = Psychologist(
      'Shevchenko Dmitry Mikhailovich',
      33,
      'Psychologist, Psychotherapist\n9 years of experience\nDmitry Mikhailovich uses methods with proven effectiveness. He constantly improves his skills and learns new techniques in foreign educational institutions. He is a member of specialized psychological associations',
      'shevchenko@gmail.com',
      '@shevchenko',
      'https://popsyapp-assets.s3.amazonaws.com/media/psychologists/psy1.jpg')
  ;

  var psy2 = Psychologist(
      'Kotsar Ekaterina Anatolyevna',
      25,
      'Psychologist\nDoctor of the highest category\n6 years of experience\nEkaterina Anatolyevna specializes in medical psychology. Conducts psychocorrection for increased anxiety, aggression, stress, loss of self, personal crises, losses, chronic fatigue, problems with self-esteem.',
      'kotsar@gmail.com',
      '@kotsar',
      'https://popsyapp-assets.s3.amazonaws.com/media/psychologists/psy2.jpg')
  ;

  var psy3 = Psychologist(
      'Chernyak Anastasia Valerievna',
      33,
      'Psychologist, Psychotherapist\nAdults and children\nHome call\nThe doctor treats depression, sleep disorders, uncontrolled aggression, irritability, panic attacks, fears, stress and disorders of difficult life circumstances (conflicts in the family, at work, serious illness, relationship breakup, loss or divorce). Helps in solving lifes problems. Also, conducts reception in English',
      'chernyak@gmail.com',
      '@chernyak',
      'https://popsyapp-assets.s3.amazonaws.com/media/psychologists/psy3.jpg')
  ;
  List<Psychologist> getPsychologists() {
    List<Psychologist> list = [
      psy1,
      psy2,
      psy3,
    ];
    return list;
  }
}