import 'dart:developer';

<<<<<<< HEAD
=======
import 'package:book_my_park/domain/api/apiendpoints.dart';
import 'package:book_my_park/domain/models/apimodel/apimodel.dart';
import 'package:book_my_park/domain/models/apimodelrepo.dart';
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

<<<<<<< HEAD
import '../domain/api/apiendpoints.dart';
import '../domain/failures/failures.dart';
import '../domain/models/apimodel/apimodel.dart';
import '../domain/models/apimodelrepo.dart';
=======
import '../domain/failures/failures.dart';
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c

@LazySingleton(as: ApiModelHazardRepo)
class ApiRepo implements ApiModelHazardRepo {
  @override
  Future<Either<MainFailure, List<Apimodel>>> getdata(
<<<<<<< HEAD
    String districtNAme,
  ) async {
    try {
      final Response response = await Dio(
        BaseOptions(),
      ).get(ApiEndpoints().getdata(districtNAme));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Apimodel> result =
            (response.data as List)
                .map((json) => Apimodel.fromJson(json))
                .toList();
=======
      String districtNAme) async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndpoints().getdata(districtNAme));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Apimodel> result = (response.data as List)
            .map((json) => Apimodel.fromJson(json))
            .toList();
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c

        return Right(result);
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return left(const MainFailure.clientFailure());
    }
  }
}
