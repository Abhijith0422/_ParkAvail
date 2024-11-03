import 'package:book_my_park/domain/failures/failures.dart';
import 'package:book_my_park/domain/models/apimodel/apimodel.dart';
import 'package:dartz/dartz.dart';
// Ensure this path is correct

abstract class ApiModelHazardRepo {
  Future<Either<MainFailure, List<Apimodel>>> getdata(String districtNAme);
}
