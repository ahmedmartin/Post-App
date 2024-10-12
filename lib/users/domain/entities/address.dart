import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String street;
  final String suite;
  final String city;
  final String zipCode;

  const Address({required this.street, required this.suite, required this.city, required this.zipCode,});
  
  @override
  List<Object?> get props => [street,suite,city,zipCode];
}
