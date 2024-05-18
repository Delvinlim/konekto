import 'package:dio/dio.dart';

// final dioClient = Dio(
//   BaseOptions(
//     // baseUrl: 'https://konekto.digitaltechnologysolution.id',
//     baseUrl: 'http://192.168.100.14:3000',
//     // baseUrl: 'http://localhost:3000',
//   ),
// );

// Function to create and configure Dio client with interceptors
Dio createDioClient() {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.100.13:3000',
  ));

  // Add an interceptor to check and attach token to requests
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Get token or refresh token
      // String? token = await getToken();

      // if (token != null) {
      //   // Attach token to headers
      //   options.headers['Authorization'] = 'Bearer $token';
      // }
      print('before requesting interceptor..');

      return handler.next(options); // continue with the request
    },
    onError: (DioException error, handler) async {
      // Handle token expiry or unauthorized errors
      if (error.response?.statusCode == 401) {
        print('error token...');
        // Token expired or invalid, attempt to refresh token
        // String? refreshedToken = await refreshToken();

        // if (refreshedToken != null) {
        //   // Retry the original request with the new token
        //   RequestOptions requestOptions = error.response!.requestOptions;
        //   requestOptions.headers['Authorization'] = 'Bearer $refreshedToken';

        //   try {
        //     var response = await dio.request<dynamic>(
        //       requestOptions.path,
        //       options: requestOptions,
        //     );
        //     return response;
        //   } catch (e) {
        //     // Failed to retry request even with refreshed token
        //     return handler.reject(e);
        //   }
        // }
      }

      return handler.next(error); // continue with the error
    },
  ));

  return dio;
}

// Function to retrieve the token (replace with your actual token retrieval logic)
Future<String?> getToken() async {
  // Example: Retrieve token from shared preferences, secure storage, etc.
  // Replace this with your actual token retrieval logic.
  return 'your_access_token_here';
}

// Function to refresh token (replace with your actual token refresh logic)
Future<String?> refreshToken() async {
  // Example: Implement token refresh logic (e.g., make a refresh token API request)
  // Replace this with your actual token refresh logic.
  return 'your_refreshed_token_here';
}

final dioClient = createDioClient();
