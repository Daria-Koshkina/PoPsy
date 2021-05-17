import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/consultationsModels/Psychologist.dart';
import 'package:po_psy/models/consultationsModels/data.dart';

import 'PsychologistItemWidget.dart';

class Consultations extends StatefulWidget {
  final List<Psychologist> _psychologists = PsychologistsData().getPsychologists();
  
  @override
  ConsultationsState createState() => ConsultationsState();
}

class ConsultationsState extends State<Consultations> {

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_searchContent);
  }

  _searchContent() {
    print("Search text field: ${myController.text}");
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Consultations", style: TextStyles.lightHeaderTextStyle,),
          brightness: Brightness.light,
        ),
        body: Container(
          color: ColorPallet.backgroundColor,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: new Row(
                      children: [
                        Expanded(child: Container(
                          padding: new EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.05),
                                  offset: Offset(0, 5),
                                  blurRadius: 30,
                                  spreadRadius: 5),
                            ],
                          ),
                          child: TextField(
                            controller: myController,
                            decoration: InputDecoration(
                              hintText: '   Search your information',
                              suffixIcon: Icon(
                                Icons.search,
                                color: ColorPallet.mainColor,),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        ),
                      ],
                    )
                ),
                Flexible(
                    child: Padding(
                        padding: new EdgeInsets.symmetric(horizontal: 20),
                        child: new SingleChildScrollView(
                            child: new Column(
                                children: widget._psychologists.map<
                                    PsychologistItemWidget>((Psychologist p) {
                                  return PsychologistItemWidget(p);
                                }).toList()
                            )
                        )
                    )
                )
              ]
          ),
        )
    );
  }

}