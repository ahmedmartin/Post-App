import 'package:clean_architecture_posts_app/users/data/models/address_model.dart';
import 'package:clean_architecture_posts_app/users/data/models/company_model.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String name,
    required String userName,
    required String phone,
    required String email,
    required CompanyModel company,
    required AddressModel address,
  }) : super(
            id: id,
            name: name,
            userName: userName,
            phone: phone,
            email: email,
            company: company,
            address: address);

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

  // Map<String, dynamic> toJson() {
  //   return {'id': id, 'name': name, 'username': userName,'phone':phone,'email':email,'address':address};
  // }
}
