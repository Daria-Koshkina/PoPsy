import 'package:po_psy/api/api.dart';
import 'package:po_psy/models/recommendationsModels/Article.dart';
import 'package:po_psy/models/recommendationsModels/Content.dart';
import 'package:po_psy/models/recommendationsModels/MusicPlaylist.dart';
import 'package:po_psy/models/recommendationsModels/Notification.dart';
import 'package:po_psy/models/recommendationsModels/Song.dart';
import 'package:po_psy/models/recommendationsModels/Video.dart';
import 'package:provider/provider.dart';

import 'VideoPlaylist.dart';
import '../../api/api.dart';

class ContentData {
  List<Content> getContent() {
    List<Song> _songs = <Song>[
      new Song(  "My song1", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'),
      new Song(  "My song2", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'),
      new Song(  "My song3", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'),
      new Song(  "My song4", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'),
    ];
    List<Video> _videos = <Video>[
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://www.youtube.com/watch?v=xhbLwKQvIpw&ab_channel=codeandartmain'),
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://www.youtube.com/watch?v=xhbLwKQvIpw&ab_channel=codeandartmain'),
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://www.youtube.com/watch?v=xhbLwKQvIpw&ab_channel=codeandartmain'),
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://www.youtube.com/watch?v=xhbLwKQvIpw&ab_channel=codeandartmain'),
    ];
    MusicPlaylist musicPlaylist = new MusicPlaylist(title: 'My music playlist', songs: _songs, imageURL: 'https://picsum.photos/250?image=9');
    VideoPlaylist videoPlaylist = new VideoPlaylist(title: 'My video playlist', videos: _videos, imageURL: 'https://picsum.photos/250?image=9');
    MyNotification notification = new MyNotification(title: 'My notification', text: 'This is notification text.', URL: 'Tests');
    MyNotification notification2 = new MyNotification(title: 'My notification', text: 'This is notification text.', URL: 'https://www.facebook.com');
    Article article = new Article(
        title: 'My article',
        author: 'Author',
        text: 'This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text ',
      URL: 'https://stakanchik.media/article/psihologicheskiy-test-komu-bi-vi-pomogli-v-pervuju-ochered',
    );

    List<Content> content = [
      musicPlaylist,
      notification,
      notification2,
      videoPlaylist,
      article
    ];

    return content;
  }
}