import 'package:dio/dio.dart';

final dio = Dio();

void getDio() async{
  final response = await dio.get('https://2475-2804-d47-6248-ee00-1058-ed0f-58af-2959.ngrok-free.app/api/product/1');
 if (response.statusCode == 200){
   final result = response.data as Map<String, dynamic>;

 }
}