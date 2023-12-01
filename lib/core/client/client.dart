import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/constans/app_constans.dart';

class Api {
  final dio = Dio();

  void getHttp() async {
    final response = await dio.get('${AppConstans.baseUrl}/');
  }
}
