import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/recommendationsModels/MusicPlaylist.dart';
import 'package:po_psy/models/recommendationsModels/Song.dart';
import 'package:po_psy/pages/homeScreen/recommendations/musicPlaylistTopWidget.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class MusicPlaylistPage extends StatefulWidget {
  MusicPlaylist musicPlaylist;

  MusicPlaylistPage({this.musicPlaylist});

  @override
  _MusicPlaylistPageState createState() => _MusicPlaylistPageState(musicPlaylist: musicPlaylist);
}

class _MusicPlaylistPageState extends State<MusicPlaylistPage> {
  final MusicPlaylist musicPlaylist;
  _PlaingSongWidget bottomSheetWidget;

  _MusicPlaylistPageState({this.musicPlaylist});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: new Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(195),
            child: new MusicPlaylistTopWidget(
              playlist: musicPlaylist,
              play: () {
                setState(() {
                  this.bottomSheetWidget = new _PlaingSongWidget(
                    song: musicPlaylist.songs[0],
                    key: UniqueKey(),
                    musicPlaylist: musicPlaylist,
                  );
                });
              },
              mix: () {
                setState(() {
                  Random random = new Random();
                  int randomNumber = random.nextInt(musicPlaylist.songs.length);
                  this.bottomSheetWidget = new _PlaingSongWidget(
                    song: musicPlaylist.songs[randomNumber],
                    key: UniqueKey(),
                    musicPlaylist: musicPlaylist,);
                });
              },
            ),
          ),
          body: new Container(
            color: ColorPallet.backgroundColor,
            padding: new EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ListView.builder(
                itemCount: musicPlaylist.songs == null ? 0 : musicPlaylist.songs
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector( //You need to make my child interactive
                      onTap: () {
                        setState(() {
                          bottomSheetWidget = new _PlaingSongWidget(
                            song: musicPlaylist.songs[index],
                            key: UniqueKey(),
                            musicPlaylist: musicPlaylist,
                          );
                        });
                      },
                      child: Padding(
                          padding: new EdgeInsets.symmetric(vertical: 6),
                          child: _SongWidget(song: musicPlaylist.songs[index])
                      )
                  );
                }
            ),
          ),
          bottomSheet: _getBottomSheetWidget(),
        )
    );
  }

  _PlaingSongWidget _getBottomSheetWidget() {
    setState(() {
      if (bottomSheetWidget == null) {
        bottomSheetWidget = new _PlaingSongWidget(
          song: musicPlaylist.songs[0],
          key: UniqueKey(),
          musicPlaylist: musicPlaylist,
        );
      }
    });
    return bottomSheetWidget;
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

class _PlaingSongWidget extends StatefulWidget {
  final Song song;
  final MusicPlaylist musicPlaylist;
  _PlaingSongWidget({Key key, this.song, this.musicPlaylist}) : super(key: key);

  @override
  _PlaingSongWidgetState createState() => new _PlaingSongWidgetState(song: song);
}

class _PlaingSongWidgetState extends State<_PlaingSongWidget> {
  Song song;
  MusicPlaylist musicPlaylist;
  _PlaingSongWidgetState({this.song});

  Duration duration;
  Duration position;
  bool isPlaying;
  bool flag;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    duration = new Duration();
    position = new Duration();
    isPlaying = false;
    flag = false;
    audioPlayer = new AudioPlayer();
    song = widget.song;
    musicPlaylist = widget.musicPlaylist;
    getAudio(song.URL);
    super.initState();
  }

  @override
  dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
            color: ColorPallet.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]
        ),
        child: Container(
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
              InkWell(
                onTap: () {
                  getAudio(song.URL);
                },
                child: Icon(
                  isPlaying == false
                      ? Icons.play_arrow_rounded
                      : Icons.pause,
                  size: 25,
                  color: ColorPallet.subsidiaryTextColor,
                ),
              ),
              IconButton(icon: Icon(
                Icons.arrow_forward, color: ColorPallet.subsidiaryTextColor,),
                onPressed: () {
                  setState(() {
                    var index = musicPlaylist.songs.indexOf(song);
                    if (index == musicPlaylist.songs.length - 1) {
                      audioPlayer.stop();
                    } else {
                      song = musicPlaylist.songs[index + 1];
                      audioPlayer.stop();
                      duration = new Duration();
                      position = new Duration();
                      isPlaying = false;
                      flag = false;
                      audioPlayer = new AudioPlayer();
                      musicPlaylist = widget.musicPlaylist;
                      getAudio(song.URL);
                      print(song.title);
                    }
                  });
                },
              ),
              IconButton(icon: Icon(
                MyIcons.clear, color: ColorPallet.subsidiaryTextColor,),
                  onPressed: () {
                    audioPlayer.stop();
                  }),
            ],
          ),
        )
    );
  }

  getAudio(String url) async {
    if (isPlaying) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          isPlaying = false;
        });
      }
    } else {
      if (flag == false) {
        var res = await audioPlayer.play(url);
        if (res == 1) {
          setState(() {
            isPlaying = true;
          });
        }
        flag = true;
      } else{
        var res = await audioPlayer.resume();
        if (res == 1) {
          setState(() {
            isPlaying = true;
          });
        }
      }
    }
    getNext();
  }

  getNext() async {
    var index = musicPlaylist.songs.indexOf(song);
    print(index);
    audioPlayer.onPlayerCompletion.listen((event) {
      //Here goes the code that will be called when the audio finishes
      //onComplete();
      if (index == musicPlaylist.songs.length - 1) {
        setState(() {
          audioPlayer.stop();
        });
      } else {
        setState(() {
          song = musicPlaylist.songs[index+1];
          //getAudio(song.URL);
          duration = new Duration();
          position = new Duration();
          isPlaying = false;
          flag = false;
          audioPlayer = new AudioPlayer();
          //song = widget.song;
          musicPlaylist = widget.musicPlaylist;
          getAudio(song.URL);
          print(song.title);
        });
      }
    });
  }
}