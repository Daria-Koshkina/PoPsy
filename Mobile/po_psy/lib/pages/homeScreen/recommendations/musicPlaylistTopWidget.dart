import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/MusicPlaylist.dart';
import 'package:share/share.dart';

class MusicPlaylistTopWidget extends StatelessWidget {
  final MusicPlaylist playlist;
  final VoidCallback play;
  final VoidCallback mix;

  MusicPlaylistTopWidget({this.playlist, this.play, this.mix});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 300,
      color: ColorPallet.redBlockColor,
      child: Column(
        children: [
          Spacer(),
          Padding(
              padding: new EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Spacer(),
                  IconButton(icon: Icon(MyIcons.exit_up, color: Colors.white,),
                      onPressed: () {
                    if (playlist.URL != null) {
                      Share.share(playlist.URL);
                    }
                      }),
                ],
              )
          ),
          Padding(padding: new EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Container(
                    width: 120,
                    height: 120,
                    child: Image.network(playlist.imageURL)),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                        children: [
                          Text(playlist.title,
                            style: TextStyles.lightHeaderTextStyle,),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  height: 36,
                                  width: 92,
                                  child: TextButton.icon(
                                    label: Text(
                                      'Play',
                                      style: TextStyles.songTitleTextStyle,),
                                    icon: Icon(
                                      Icons.play_arrow_rounded,
                                      color: ColorPallet.subsidiaryTextColor,
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: ColorPallet
                                          .lightGreyColor,
                                    ),
                                    onPressed: () => play(),
                                  )
                              ),
                              Spacer(),
                              SizedBox(
                                  height: 36,
                                  width: 92,
                                  child: TextButton.icon(
                                    label: Text(
                                      'Mix',
                                      style: TextStyles.songTitleTextStyle,),
                                    icon: Icon(
                                      Icons.autorenew,
                                      color: ColorPallet.subsidiaryTextColor,
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: ColorPallet
                                          .lightGreyColor,
                                    ),
                                    onPressed: () => mix(),
                                  )
                              ),
                            ],
                          )
                        ]
                    )
                )
              ],
            ),)
        ],
      ),
    );
  }
}