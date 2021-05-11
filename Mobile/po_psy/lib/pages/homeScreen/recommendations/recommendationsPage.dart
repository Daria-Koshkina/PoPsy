import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:po_psy/models/recommendationsModels/data.dart';
import 'package:po_psy/pages/homeScreen/recommendations/contentWidget.dart';


class RecommendationsPage extends StatefulWidget {
  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

  class _RecommendationsPageState extends State<RecommendationsPage> {
    final List<Content> _content = ContentData().getContent();

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
      return Container(
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
                            Icons.search, color: ColorPallet.mainColor,),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    ),
                    IconButton(icon: Icon(MyIcons.calendar, color: ColorPallet.mainColor,), onPressed: (){}),
                  ],
                )
            ),
            Flexible(
                child: Padding(
                    padding: new EdgeInsets.symmetric(horizontal: 20),
                    child: new SingleChildScrollView(
                        child: new Column(
                            children: [
                              ContentWidget(content: _content,),
                            ]
                        )
                    )
                )
            )
          ],
        ),
      );
    }
  }