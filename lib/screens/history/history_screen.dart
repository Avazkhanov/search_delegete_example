import 'package:flutter/material.dart';
import 'package:search_delegete_example/data/local/places_data.dart';
import 'package:search_delegete_example/utils/style/app_style.dart';

class SearchHistoryScreen extends StatelessWidget {
  const SearchHistoryScreen({Key? key}) : super(key: key);

  Future<List<String>> _getSearchQueries() async {
    return await PlacesDatabase.instance.getSearchQueries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Qidiruv Tarixi",
          style: AppStyle.poppinsSemiBold.copyWith(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _getSearchQueries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Xatolik yuz berdi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Qidiruv tarixi mavjud emas"),
            );
          } else {
            final searchQueries = snapshot.data!;
            return ListView.builder(
              itemCount: searchQueries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchQueries[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
