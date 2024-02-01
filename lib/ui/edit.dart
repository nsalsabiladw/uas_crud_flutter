import 'package:flutter/material.dart';
import 'package:uas_crud_flutter/service/api_service.dart';
import 'package:uas_crud_flutter/ui/homepage.dart';

import '../model/model.dart';

class EditData extends StatefulWidget {
  final Map listData;
  EditData({super.key, required this.listData});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController nim = TextEditingController();
  TextEditingController prodi = TextEditingController();
  TextEditingController alamat = TextEditingController();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    id.text = widget.listData['id'];
    nama.text = widget.listData['nama'];
    nim.text = widget.listData['nim'];
    prodi.text = widget.listData['prodi'];
    alamat.text = widget.listData['alamat'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama belum di input';
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: nim,
                decoration: InputDecoration(
                    hintText: "NIM",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'NIM belum di input';
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: prodi,
                decoration: InputDecoration(
                    hintText: "Prodi",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Prodi belum di input';
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                    hintText: "Alamat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Alamat belum di input';
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),

                  //ini logika update, manggil api service nya
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (id.text.isNotEmpty &&
                          nama.text.isNotEmpty &&
                          nim.text.isNotEmpty &&
                          prodi.text.isNotEmpty &&
                          alamat.text.isNotEmpty) {
                        await apiService.editPost(int.parse(id.text.toString()), nama.text.toString(),
                            nim.text.toString(), prodi.text.toString(), alamat.text.toString());
                      } else {
                        print('One or more fields are empty');
                      }
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  },
                  child: Text("UPDATE"))
            ],
          ),
        ),
      ),
    );
  }
}
