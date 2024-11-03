import 'dart:developer';

import 'package:book_my_park/domain/api/apiendpoints.dart';
import 'package:book_my_park/domain/models/apimodel/apimodel.dart';
import 'package:book_my_park/domain/models/apimodelrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../domain/failures/failures.dart';

@LazySingleton(as: ApiModelHazardRepo)
class ApiRepo implements ApiModelHazardRepo {
  @override
  Future<Either<MainFailure, List<Apimodel>>> getdata(
      String districtNAme) async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndpoints().getdata(districtNAme));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Apimodel> result = (response.data as List)
            .map((json) => Apimodel.fromJson(json))
            .toList();

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
