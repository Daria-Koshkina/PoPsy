import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Video.dart';

class VideoPlaylistWidget extends StatelessWidget {
  final List<Video> videos;
  final Color color;
  final String title;

  const VideoPlaylistWidget({Key key, this.videos, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: new Row(
                      children: [
                        Text(title,
                          style: TextStyles.lightHeaderTextStyle,),
                        Spacer(),
                        IconButton(icon: Icon(Icons.arrow_forward_ios,
                          color: Colors.white,), onPressed: () {})
                      ]
                  )
              ),
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),

                      child: new SingleChildScrollView(

                          child: new Column(
                              children: videos.map((Video video) {
                                return _Song(video: video,);
                              }).toList()
                          )
                      )
                  )
              )
            ]
        ),
      ),
    );
  }
}

class _Song extends StatelessWidget {
  final Video video;
  const _Song({Key key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.fromLTRB(0, 5, 70, 5),
      padding: new EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      height: 50,
      decoration: BoxDecoration(
        color: ColorPallet.lightGreyColor,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(video.imageURL),
          ),
          SizedBox(width: 5,),
          Column(
            children: [
              Text(video.title, style: TextStyles.songTitleTextStyle,),
              Text(video.author, style: TextStyles.authorTitleTextStyle,)
            ],
          )
        ],
      ),
    );
  }

}