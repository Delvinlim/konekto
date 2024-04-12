import 'package:dio/dio.dart';

final dioClient = Dio(
  BaseOptions(
    // baseUrl: 'https://konekto.digitaltechnologysolution.id',
    baseUrl: 'http://192.168.100.11:3000',
    // baseUrl: 'http://localhost:3000',
  ),
);
