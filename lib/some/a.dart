import 'dart:convert';
import 'package:http/http.dart';


class contact{
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  contact({required this.id,required this.name,required this.username,required this.email,required this.phone,required this.website});
  factory contact.fromJson(Map<String,dynamic>json){
    return contact(
      id:json['id'],
      name:json['name'],
      username:json['username'],
      email:json['email'],
      phone:json['phone'],
      website:json['website']
    );
  }
}

class a{
  Future <List<contact>>getcontact() async{
    Response response=await get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode==200){
      final List contacts=jsonDecode(response.body);
      return contacts.map((e) => contact.fromJson(e)).toList();
    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }
}
