class Category {
  final String title;
  Category(this.title);

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
        json['text']
    );
  }
}