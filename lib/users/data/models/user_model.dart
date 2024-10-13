import 'package:clean_architecture_posts_app/users/data/models/address_model.dart';
import 'package:clean_architecture_posts_app/users/data/models/company_model.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';

class UserModel {
  final int id;
  final String name;
  final String userName;
  final String phone;
  final String email;
  final CompanyModel company;
  final AddressModel address;

    UserModel({required this.id, required this.name, required this.userName, required this.phone, required this.email, required this.company, required this.address,});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      userName: json['username'],
      phone: json['phone'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']),
      company: CompanyModel.fromJson(json['company']),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': userName,
      'phone': phone,
      'email': email,
      'address': address.toJson(),
      'company':company.toJson(),
    };
  }
}

extension MapToDomain on UserModel {
  User toDomain() => User(
        id: id,
        name: name,
        userName: userName,
        phone: phone,
        email: email,
        company: company,
        address: address,
      );
}
