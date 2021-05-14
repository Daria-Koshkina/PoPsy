import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/recommendationsModels/MusicPlaylist.dart';
import 'package:po_psy/models/recommendationsModels/Song.dart';
import 'package:po_psy/pages/homeScreen/recommendations/musicPlaylistPage.dart';

class MusicPlaylistWidget extends StatelessWidget {
  final MusicPlaylist musicPlaylist;
  final Color color;

  const MusicPlaylistWidget({Key key, this.musicPlaylist, this.color})
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
                        Text(musicPlaylist.title,
                          style: TextStyles.lightHeaderTextStyle,),
                        Spacer(),
                        Material(
                            color: ColorPallet.redBlockColor,
                            child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white,), onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MusicPlaylistPage(
                                      musicPlaylist: musicPlaylist,)),
                              );
                            })
                        )
                      ]
                  )
              ),
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),

                      child: new SingleChildScrollView(

                          child: new Column(
                              children: musicPlaylist.songs.map((Song song) {
                                return _Song(song: song,);
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
  final Song song;
  const _Song({Key key, this.song}) : super(key: key);

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
            child: Image.network(song.imageURL),
          ),
          SizedBox(width: 5,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyles.songTitleTextStyle,
              ),
              Text(
                song.author,
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