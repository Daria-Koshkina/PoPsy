class Video {
  final String title;
  final String author;
  final String imageURL;
  final String time;
  final String URL;

  Video(this.title, this.author, this.time, this.imageURL, this.URL);

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
        json['title'],
        json['author'],
        json['time'],
        json['image'],
        json['url']
    );
  }
}