import '../entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, User>> getUserById({required String userId});
}
