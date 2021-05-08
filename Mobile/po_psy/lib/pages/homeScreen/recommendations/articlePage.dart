import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Article.dart';
import 'package:po_psy/pages/homeScreen/recommendations/articleTopWidget.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  ArticlePage({this.article});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: new Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(195),
            child: new ArticleTopWidget(
              article: article,
            ),
          ),
          body: new Container(
              color: ColorPallet.yellowBlockColor,
              padding: new EdgeInsets.fromLTRB(20, 20, 20, 20),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
              child:  Text(
                  article.text,
                  style: TextStyles.commonTextStyle,
                ),
              )
          ),
        )
    );
  }

}