import 'package:flutter/material.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/stateConstants/ContentStates.dart';
import 'package:po_psy/models/recommendationsModels/Article.dart';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:po_psy/models/recommendationsModels/MusicPlaylist.dart';
import 'package:po_psy/models/recommendationsModels/VideoPlaylist.dart';
import 'package:po_psy/pages/homeScreen/recommendations/articleWidget.dart';
import 'package:po_psy/pages/homeScreen/recommendations/musicPlaylist.dart';
import 'package:po_psy/pages/homeScreen/recommendations/notificationWidget.dart';
import 'package:po_psy/pages/homeScreen/recommendations/videoPlaylist.dart';
import 'package:po_psy/models/recommendationsModels/Notification.dart';

class ContentWidget extends StatefulWidget {
  final List<Content> content;

  const ContentWidget({Key key, this.content}) : super(key: key);
  ContentWidgetState createState() => ContentWidgetState();
}

class ContentWidgetState extends State<ContentWidget> {
  Future<List<MusicPlaylist>> _content;

  @override
  void initState() {
    //_content = ApiManager().getPlayLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return new SingleChildScrollView(
    //   child: Container(
    //     child: FutureBuilder(
    //       future: _content,
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return new Column(
    //               children:
    //               snapshot.data.map<Widget>((Content c) {
    //                 return Padding(
    //                     padding: new EdgeInsets.symmetric(vertical: 8),
    //                     child: myWidget(content: c)
    //                 );
    //               }).toList());
    //         } else {
    //           return CircularProgressIndicator();
    //         }
    //       },
    //     ),
    //   ),
    // );

    return new SingleChildScrollView(
      child: Container(
          child: new Column(
              children:
              widget.content.map<Widget>((Content c) {
                return Padding(
                    padding: new EdgeInsets.symmetric(vertical: 8),
                    child: myWidget(content: c)
                );
              }).toList())
      ),
    );
  }
}

class myWidget extends StatelessWidget {
  final Content content;
  const myWidget({this.content});

  @override
  Widget build(BuildContext context) {
    if (content.status == ContentStates.musicPlaylistStatus) {
      MusicPlaylist mp = content as MusicPlaylist;
      return MusicPlaylistWidget(
          musicPlaylist: mp,
          color: ColorPallet.redBlockColor);
    }
    else if (content.status == ContentStates.videoPlaylistStatus) {
      VideoPlaylist vp = content as VideoPlaylist;
      return VideoPlaylistWidget(
          videoPlaylist: vp,
          color: ColorPallet.blueBlockColor);
    }
    else if (content.status == ContentStates.notificationStatus) {
      MyNotification notification = content as MyNotification;
      return NotificationWidget(notification: notification);
    }
    else {
      Article article = content as Article;
      return ArticleWidget(article: article,);
    }
  }
}