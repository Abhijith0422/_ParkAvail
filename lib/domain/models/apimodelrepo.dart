<<<<<<< HEAD
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import 'apimodel/apimodel.dart';
=======
import 'package:book_my_park/domain/failures/failures.dart';
import 'package:book_my_park/domain/models/apimodel/apimodel.dart';
import 'package:dartz/dartz.dart';
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
// Ensure this path is correct

abstract class ApiModelHazardRepo {
  Future<Either<MainFailure, List<Apimodel>>> getdata(String districtNAme);
}
