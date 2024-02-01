import 'package:flutter/material.dart';
import 'package:uas_crud_flutter/service/api_service.dart';
import 'package:uas_crud_flutter/ui/homepage.dart';

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController nim = TextEditingController();
  TextEditingController prodi = TextEditingController();
  TextEditingController alamat = TextEditingController();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Data'),
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
                  borderRadius: BorderRadius.circular(15)
                )
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return 'Nama belum di input';
                }
              },
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: nim,
              decoration: InputDecoration(
                  hintText: "NIM",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return 'NIM belum di input';
                }
              },
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: prodi,
              decoration: InputDecoration(
                hintText: "Prodi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return 'Prodi belum di input';
                }
              },
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: alamat,
              decoration: InputDecoration(
                  hintText: "Alamat",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return 'Alamat belum di input';
                }
              },
            ),
            SizedBox(height: 15,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                onPressed: () async {
                  if(formKey.currentState!.validate()){
                    await apiService.createPost(
                        nama.text.toString(),
                        nim.text.toString(),
                        prodi.text.toString(),
                        alamat.text.toString()
                    );
                  }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false
                  );
                },
                child: Text("SAVE"))
          ],
        ),
      ),),
    );
  }
}
