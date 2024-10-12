import 'package:clean_architecture_posts_app/users/domain/entities/address.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/company.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
    final String name;
    final String userName;
    final String phone;
    final String email;
    final Company company;
    final Address address;

  const User({required this.id, required this.name, required this.userName, required this.phone, required this.email, required this.company, required this.address,});

  

  @override
  List<Object?> get props => [id, name, userName,phone,email,company,address,];
}
