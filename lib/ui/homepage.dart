import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uas_crud_flutter/response/response.dart';
import 'package:uas_crud_flutter/ui/create.dart';
import 'package:uas_crud_flutter/ui/edit.dart';
import 'package:uas_crud_flutter/ui/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listPost = [];

  Future<PostResponse?> getPosts() async {
    try {
      final response =
          await Dio().get('http://192.168.1.45/flutterapi/crudflutter/db.php');
      if (response.statusCode == 200) {
        print(response.data);
        final data = jsonDecode(response.data);
        setState(() {
          listPost = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPosts();
    print(listPost);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
        actions: [
          IconButton(
              //manggil class dari search delegate nya
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: DataSearch((query) {
                      print(query);
                    }));
                debugPrint('Test cari');
                // apiService.searchData(query);

                // Tambahkan logika pencarian di sini
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
          itemCount: listPost.length,
          itemBuilder: ((context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => EditData(
                            listData: {
                              'id': listPost[index]['id'],
                              'nama': listPost[index]['nama'],
                              'nim': listPost[index]['nim'],
                              'prodi': listPost[index]['prodi'],
                              'alamat': listPost[index]['alamat'],
                            },
                          )),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(listPost[index]['nama']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listPost[index]['nim']),
                      Text(listPost[index]['prodi']),
                      Text(listPost[index]['alamat']),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => CreateData())));
        },
      ),
    );
  }
}
