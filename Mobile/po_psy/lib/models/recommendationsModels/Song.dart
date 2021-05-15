class Song {
  final String title;
  final String author;
  final String imageURL;
  final String time;
  final String URL;

  Song( this.title, this.author, this.time, this.imageURL, this.URL);

  factory Song.fromJson(Map<String, dynamic> json){
    return Song(
        json['title'],
        json['author'],
        json['time'],
        json['image'],
        json['url']
    );
  }
}