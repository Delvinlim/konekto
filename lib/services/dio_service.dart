import 'package:dio/dio.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: 'https://konekto.digitaltechnologysolution.id',
    connectTimeout: const Duration(seconds: 5),
  ),
);
