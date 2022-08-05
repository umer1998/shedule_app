class UserModel{
  String? uid;
  String? email;
  String? image;
  String? phoneno;
  String? profession;
  String? name;

  UserModel({this.uid, this.email, this.name, this.phoneno, this.image, this.profession});

  //receive data from server
  factory UserModel.fromMap(map){
   return UserModel(
     uid:map['uid'],
     email:map['email'],
     image:map['image'],
     phoneno:map['phoneno'],
     profession:map['profession'],
     name:map['name']
   );
  }

  //send data from server
  Map<String, dynamic> toMap(){
    return{
      'uid':uid,
      'email':email,
      'phoneno':phoneno,
      'image':image,
      'profession':profession,
      'name':name,
    };
  }


}