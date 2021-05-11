import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/recommendationsModels/VideoPlaylist.dart';
import 'package:share/share.dart';

class VideoPlaylistTopWidget extends StatelessWidget {
  final VideoPlaylist playlist;

  VideoPlaylistTopWidget({this.playlist});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 300,
      color: ColorPallet.blueBlockColor,
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
          Padding(padding: new EdgeInsets.symmetric(
              horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Container(
                    width: 120,
                    height: 120,
                    child: Image.network(playlist.imageURL)),
                SizedBox(
                  width: 20,
                ),
                Padding(padding: new EdgeInsets.only(bottom: 40),
                    child: Text(
                      playlist.title,
                      style: TextStyles.lightHeaderTextStyle,
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}