import 'package:clean_architecture_posts_app/users/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required String street,
    required String suite,
    required String city,
    required String zipCode,
  }) : super(street: street, suite: suite, city: city,zipCode:zipCode,);

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        street: json['street'],
        suite: json['suite'],
        city: json['city'],
        zipCode: json['zipcode'],
        );
  }

  Map<String, dynamic> toJson() {
    return {'street': street, 'suite': suite, 'city': city,'zipcode':zipCode,};
  }

}