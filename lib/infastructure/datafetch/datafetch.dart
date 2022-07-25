import 'package:dartz/dartz.dart';
import 'package:doctorbuddy/domain/datafetch/idatafetch.dart';
import 'package:doctorbuddy/domain/failures.dart';
import 'package:doctorbuddy/domain/user/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:injectable/injectable.dart';

import '../../presentation/Screens/Login/verificationscreen.dart';

@LazySingleton(as: IDataFetch)
class FetchRepositry implements IDataFetch {
  @override
  Future<Either<MainFailure, PUserModel>> getdata() async {
    try {
      auth.User? user = auth.FirebaseAuth.instance.currentUser;

      // PUserModel cuser = PUserModel();
      final result = await firestore.collection('pusers').doc(user!.uid).get();
      PUserModel cuser = PUserModel.fromMap(result.data());
      return Right(cuser);
    } catch (e) {
      throw Left(MainFailure.clientFailure());
    }
  }
}
