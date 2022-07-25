import 'package:dartz/dartz.dart';
import 'package:doctorbuddy/domain/user/usermodel.dart';
import 'package:injectable/injectable.dart';

import '../failures.dart';

abstract class IDataFetch {
  Future<Either<MainFailure, PUserModel>> getdata();
}
