import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({required this.name, required this.catchPhrase, required this.bs});

  @override
  List<Object?> get props => [name,catchPhrase,bs];
}
