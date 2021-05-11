import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Video.dart';
import 'package:po_psy/models/VideoPlaylist.dart';
import 'package:po_psy/pages/homeScreen/recommendations/videoPlaylistTopWidget.dart';
import 'package:url_launcher/url_launcher.dart';


class VideoPlaylistPage extends StatelessWidget {
  final VideoPlaylist videoPlaylist;
  VideoPlaylistPage({this.videoPlaylist});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: new Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(195),
            child: new VideoPlaylistTopWidget(
              playlist: videoPlaylist,
            ),
          ),
          body: new Container(
            color: ColorPallet.backgroundColor,
            padding: new EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ListView.builder(
                itemCount: videoPlaylist.videos == null ? 0 : videoPlaylist.videos
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      onTap: () {
                        _launchURL(videoPlaylist.videos[index].URL);
                      },
                      child: Padding(
                          padding: new EdgeInsets.symmetric(vertical: 6),
                          child: _VideoWidget(video: videoPlaylist.videos[index])
                      )
                  );
                }
            ),
          ),
        )
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _VideoWidget extends StatelessWidget {
  final Video video;
  _VideoWidget({this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPallet.backgroundColor,
      ),
      height: 96,
      child: new Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
                children: [
                  SizedBox(
                      width: 140,
                      height: 96,
                      child: Image.network(
                        video.imageURL,
                        fit: BoxFit.fitWidth,
                      )
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 96,
                    width: 140,
                    child: Container(
                        margin: new EdgeInsets.all(5),
                        height: 12,
                        width: 30,
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: Text(
                          video.time,
                          style: TextStyles.lightSubHeaderTextStyle,
                        )
                    ),
                  )
                ]
            ),
          ),
          Padding(padding: new EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(video.title, style: TextStyles.songTitleTextStyle,),
                  Row(
                    children: [
                      Text(
                        video.author,
                        style: TextStyles.authorTitleTextStyle,),
                      Icon(Icons.arrow_left_rounded,
                          color: ColorPallet.subsidiaryTextColor),
                      Text(
                        video.time, style: TextStyles.authorTitleTextStyle,),
                    ],
                  ),
                ],
              )
          ),
          Spacer(),
          IconButton(icon: Icon(
            MyIcons.more_vert, color: ColorPallet.subsidiaryTextColor,),
              onPressed: () {}),
        ],
      ),
    );
  }
}