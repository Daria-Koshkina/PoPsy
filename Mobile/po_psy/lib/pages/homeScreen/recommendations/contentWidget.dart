import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/models/Article.dart';
import 'package:po_psy/models/Content.dart';
import 'package:po_psy/models/MusicPlaylist.dart';
import 'package:po_psy/models/VideoPlaylist.dart';
import 'package:po_psy/pages/homeScreen/recommendations/articleWidget.dart';
import 'package:po_psy/pages/homeScreen/recommendations/musicPlaylist.dart';
import 'package:po_psy/pages/homeScreen/recommendations/notificationWidget.dart';
import 'package:po_psy/pages/homeScreen/recommendations/videoPlaylist.dart';
import 'package:po_psy/models/Notification.dart';

class ContentWidget extends StatelessWidget {
  final List<Content> content;
  const ContentWidget({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new Column(
            children:
              content.map((Content c) {
                return Padding(padding: new EdgeInsets.symmetric(vertical: 8),
                    child: myWidget(content: c)
                );
              }).toList(),
        )
    );
  }
}

class myWidget extends StatelessWidget {
  final Content content;
  const myWidget({this.content});

  @override
  Widget build(BuildContext context) {
    if (content.status == 'Songs') {
      MusicPlaylist mp = content as MusicPlaylist;
      return MusicPlaylistWidget(
          musicPlaylist: mp,
          color: ColorPallet.redBlockColor);
    }
    else if (content.status == 'Videos') {
      VideoPlaylist vp = content as VideoPlaylist;
      return VideoPlaylistWidget(
          videoPlaylist: vp,
          color: ColorPallet.blueBlockColor);
    }
    else if (content.status == 'Notification') {
      MyNotification notification = content as MyNotification;
      return NotificationWidget(notification: notification);
    }
    else {
      Article article = content as Article;
      return ArticleWidget(article: article,);
    }
  }
}