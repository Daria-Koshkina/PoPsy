class Category {
  final String title;
  Category(this.title);

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
        json['text']
    );
  }

  Map<String,dynamic> toPost(){
    final paramDic = {
      "title" : title,
    };
    return paramDic;
  }
}