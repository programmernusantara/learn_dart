import 'package:dio/dio.dart';

final dio = Dio();
void main() async {
  final response = await dio.get('https://digtren.netlify.app/');
  print(response);
}
