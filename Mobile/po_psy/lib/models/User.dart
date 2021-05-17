class User {
  int ID;
  String name;
  String surname;
  String imageURL;
  String email;
  String phone;
  int age;
  String password;
  List testResult;

  User(this.ID, this.name, this.surname, this.imageURL, this.email,
      this.phone, this.age, this.password, this.testResult);

  Map<String,dynamic> toPost(){
    final paramDic = {
      "id" : ID.toString(),
      "name" : name,
      "surname" : surname,
      "image" : imageURL,
      "email": email,
      "phone" : phone!=null? phone:'',
      "age" : age.toString(),
      "password": password,
    };
    return paramDic;
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        json['id'],
        json['name'],
        json['surname'],
        json['photo'],
        json['email'],
        json['phone'],
        json['age'],
        json['password'],
        null
    );
  }
}