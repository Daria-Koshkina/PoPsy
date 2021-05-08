import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Article.dart';

class ArticleTopWidget extends StatelessWidget {
  final Article article;
  ArticleTopWidget({this.article});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 300,
      color: ColorPallet.placeholderColor,
      child: Column(
        children: [
          SizedBox(height: 35,),
          Padding(
              padding: new EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Spacer(),
                  IconButton(icon: Icon(MyIcons.exit_up, color: Colors.white,),
                      onPressed: () {}),
                ],
              )
          ),
          SizedBox(height: 20,),
          Text(
              article.title,
            style: TextStyles.lightHeaderTextStyle,
          ),
          Text(
            article.author,
            style: TextStyles.lightHeader2TextStyle,
          )
        ],
      ),
    );
  }

}