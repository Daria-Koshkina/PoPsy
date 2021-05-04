import 'package:po_psy/models/Article.dart';
import 'package:po_psy/models/Content.dart';
import 'package:po_psy/models/MusicPlaylist.dart';
import 'package:po_psy/models/Notification.dart';
import 'package:po_psy/models/Song.dart';
import 'package:po_psy/models/Video.dart';

import 'VideoPlaylist.dart';

class ContentData {
  List<Content> getContent() {
    List<Song> _songs = <Song>[
      new Song( "My song", 'Author', '3.25', 'https://picsum.photos/250?image=9'),
      new Song( "My song", 'Author', '3.25', 'https://picsum.photos/250?image=9'),
      new Song( "My song", 'Author', '3.25', 'https://picsum.photos/250?image=9'),
      new Song( "My song", 'Author', '3.25', 'https://picsum.photos/250?image=9'),
    ];
    List<Video> _videos = <Video>[
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://picsum.photos/250?image=9'),
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://picsum.photos/250?image=9'),
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://picsum.photos/250?image=9'),
      new Video( "My video", 'Author', '3.25', 'https://picsum.photos/250?image=9', 'https://picsum.photos/250?image=9'),
    ];
    MusicPlaylist musicPlaylist = new MusicPlaylist(title: 'My music playlist', songs: _songs);
    VideoPlaylist videoPlaylist = new VideoPlaylist(title: 'My video playlist', videos: _videos);
    MyNotification notification = new MyNotification(title: 'My notification', text: 'This is notification text.');
    Article article = new Article(title: 'My article', author: 'Author', text: 'This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text This is article text ');

    List<Content> content = [
      musicPlaylist,
      notification,
      videoPlaylist,
      article
    ];

    content.forEach((element) {
      print(element.title);
      if (element.status == 'Article') {
        Article article = element as Article;
        print(article.author);
      }
    });
    return content;
  }
}