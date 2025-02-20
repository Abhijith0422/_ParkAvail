import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import 'apimodel/apimodel.dart';
// Ensure this path is correct

abstract class ApiModelHazardRepo {
  Future<Either<MainFailure, List<Apimodel>>> getdata(String districtNAme);
}
