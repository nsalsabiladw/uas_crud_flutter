import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:uas_crud_flutter/model/model.dart';

class ApiService {
  List<PostModel> listPost = [];

  Future<List<PostModel>> searchData(String? query) async {
    final response = await Dio().get(
        'http://192.168.1.45/flutterapi/crudflutter/view_data_like.php/?nama=${query}');

    debugPrint('Search result : ${response.data}');
    try {
      if (response.statusCode == 200) {
        print(response.data);
        final data = jsonDecode(response.data);
        //data yang muncul saat di search dibungkus dalam suatu array/list
        return listPost = ((data as List)[0] as List)
            .map((i) => PostModel.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
    return listPost;
  }

  Future<PostModel?> createPost(
      String nama, String nim, String prodi, String alamat) async {
    try {
      final response = await Dio().post(
        'http://192.168.1.45/flutterapi/crudflutter/create.php',
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
        data: {'nama': nama, 'nim': nim, 'prodi': prodi, 'alamat': alamat},
      );

      debugPrint('New POST : ${response.data}');
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return PostModel(
              id: response.data['id'] != null
                  ? int.parse(response.data['id'])
                  : 0,
              nama: response.data['nama'],
              nim: response.data['nim'],
              prodi: response.data['prodi'],
              alamat: response.data['alamat']);
        } else {
          // Handle kesalahan jika tipe data tidak sesuai
          return null;
        }
      }
      return null;
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  //ini api service buat edit, disitu kan id nya berbentuk int. terus mau diganti di string gitukan ya
  Future<PostModel?> editPost(
      int id, String nama, String nim, String prodi, String alamat) async {
    try {
      final response = await Dio().put(
        'http://192.168.1.45/flutterapi/crudflutter/edit.php/${id}',
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
        data: {
          'id': id,
          'nama': nama,
          'nim': nim,
          'prodi': prodi,
          'alamat': alamat
        },
      );

      debugPrint('Edit POST : ${response.data}');
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return PostModel(
              id: response.data['id'] != null
                  ? int.parse(response.data['id'].toString())
                  : 0,
              nama: response.data['nama'],
              nim: response.data['nim'],
              prodi: response.data['prodi'],
              alamat: response.data['alamat']);
        } else {
          // Handle kesalahan jika tipe data tidak sesuai
          return null;
        }
      } else {
        // Handle kesalahan jika status kode bukan 200
        debugPrint(
            'Status code: ${response.statusCode}, message: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }
}
