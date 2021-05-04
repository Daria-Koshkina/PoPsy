import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/MusicPlaylist.dart';
import 'package:po_psy/models/Song.dart';

class MusicPlaylistPage extends StatefulWidget {
  final MusicPlaylist musicPlaylist;
  MusicPlaylistPage({this.musicPlaylist});

  @override
  _MusicPlaylistPageState createState() => _MusicPlaylistPageState(musicPlaylist: musicPlaylist);
}

class _MusicPlaylistPageState extends State<MusicPlaylistPage> {
  final MusicPlaylist musicPlaylist;

  _MusicPlaylistPageState({this.musicPlaylist});

  AudioPlayer audioPlayer = new AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallet.redBlockColor,
      ),
        body: new Container(
          color: ColorPallet.backgroundColor,
          height: 500,
          padding: new EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: musicPlaylist.songs.map((Song song) {
              return Padding(
                  padding: new EdgeInsets.symmetric(vertical: 6),
                  child: _SongWidget(song: song)
              );
            }).toList(),
          ),
        )
    );
  }
}

class _SongWidget extends StatelessWidget {
  final Song song;
  _SongWidget({this.song});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          decoration: BoxDecoration(
            color: ColorPallet.backgroundColor,
          ),
          height: 50,
          child: new Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(song.imageURL),
              ),
              Padding(padding: new EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Text(song.title, style: TextStyles.songTitleTextStyle,),
                      Row(
                        children: [
                          Text(
                            song.author,
                            style: TextStyles.authorTitleTextStyle,),
                          Icon(Icons.arrow_left_rounded,
                              color: ColorPallet.subsidiaryTextColor),
                          Text(
                            song.time, style: TextStyles.authorTitleTextStyle,),
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
        )
    );
  }
}