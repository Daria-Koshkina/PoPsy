class SongPlayList{
  final int SongId;
  final int PlaylistId;

  SongPlayList(this.SongId, this.PlaylistId);

  factory SongPlayList.fromJson(Map<String, dynamic> json){
    return SongPlayList(
        json['audioId'],
        json['audioListId']
    );
  }
}