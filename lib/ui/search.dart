import 'package:flutter/material.dart';
import 'package:uas_crud_flutter/model/model.dart';
import 'package:uas_crud_flutter/service/api_service.dart';

class DataSearch extends SearchDelegate<String> {
  final Function(String) onSearch;

  DataSearch(this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    final apiService = ApiService();

    return FutureBuilder<List<PostModel>>(
      future: apiService.searchData(query),
      builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<PostModel> postResponse = snapshot.data!;
          return ListView.builder(
            itemCount: postResponse.length,
            itemBuilder: (context, index) {
              PostModel postModel = postResponse[index];
              return Card(
                child: ListTile(
                  title: Text(postModel.nama ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NIM: ${postModel.nim ?? 'No NIM'}"),
                      Text("Prodi: ${postModel.prodi ?? 'No Prodi'}"),
                      Text("Alamat: ${postModel.alamat ?? 'No Address'}"),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Mahasiswa..'),
    );
    // Menampilkan saran pencarian saat pengguna mengetik
  }
}