import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/recommendationsModels/Video.dart';
import 'package:po_psy/models/recommendationsModels/VideoPlaylist.dart';
import 'package:po_psy/pages/homeScreen/recommendations/videoPlaylistPage.dart';

class VideoPlaylistWidget extends StatelessWidget {
final VideoPlaylist videoPlaylist;
final Color color;

  const VideoPlaylistWidget({Key key, this.videoPlaylist, this.color})
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
                        Text(videoPlaylist.title,
                          style: TextStyles.lightHeaderTextStyle,),
                        Spacer(),
                        IconButton(icon: Icon(Icons.arrow_forward_ios,
                          color: Colors.white,), onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                VideoPlaylistPage(
                                  videoPlaylist: videoPlaylist,)),
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
                              children: videoPlaylist.videos.map((Video video) {
                                return _Video(video: video,);
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

class _Video extends StatelessWidget {
  final Video video;

  const _Video({Key key, this.video}) : super(key: key);

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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(video.imageURL),
          ),
          SizedBox(width: 5,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyles.songTitleTextStyle,
              ),
              Text(
                video.author,
                style: TextStyles.authorTitleTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,)
            ],
          )
          )
        ],
      ),
    );
  }
}