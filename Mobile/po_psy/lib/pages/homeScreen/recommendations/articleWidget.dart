import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/recommendationsModels/Article.dart';
import 'package:po_psy/pages/homeScreen/recommendations/articlePage.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  ArticleWidget({this.article});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 260,
      decoration: BoxDecoration(
        color: Color(0xFFF9F1A8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: new Row(
                    children: [
                      Expanded(child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(article.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyles.lightHeaderTextStyle,),
                        SizedBox(height: 5,),
                        Text(article.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyles.lightHeader2TextStyle,),
                      ])),
                      Spacer(),
                      IconButton(icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.white,), onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ArticlePage(
                                article: article,)),
                        );
                      })
                    ]
                )
            ),
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new SingleChildScrollView(
                        child: new Column(
                            children: [
                              Text(article.text, style: TextStyles.articleTextTextStyle,)
                            ]
                        )
                    )
                )
            )
          ]
      ),
    );
  }
}