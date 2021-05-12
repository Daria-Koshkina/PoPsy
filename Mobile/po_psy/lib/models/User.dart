class User {
  final int ID;
  final String name;
  final String surname;
  final String imageURL;
  final String email;
  final String phone;
  final int age;
  final String password;
  final List testResult;

  User(this.ID, this.name, this.surname, this.imageURL, this.email,
      this.phone, this.age, this.password, this.testResult);

  Map<String,dynamic> toPost(){
    final paramDic = {
      "name" : name,
      "surname" : surname,
      "image" : imageURL,
      "email": email,
      "phone" : phone,
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
        json['image'],
        json['email'],
        json['phone'],
        json['age'],
        json['password'],
        null
    );
  }
}