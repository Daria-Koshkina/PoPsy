import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/consultationsModels/Psychologist.dart';
import 'package:po_psy/pages/consultations/PsychologistPage.dart';

class PsychologistItemWidget extends StatelessWidget {
  final Psychologist _psychologist;
  const PsychologistItemWidget(this._psychologist);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPallet.mainColor,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(_psychologist.imageURL, fit: BoxFit.fill, width: 70, height: 70,),
              ),
              SizedBox(width: 10,),
              Text(
                _psychologist.name,
                style: TextStyles.lightHeader2TextStyle,
              ),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white,),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                        new PsychologistPage(_psychologist))
                    );
                  }
                  )
            ]
        )
    );
  }

}