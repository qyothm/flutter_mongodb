import 'package:contact_app/dbHelper/mongodb.dart';
import 'package:contact_app/model/mongoDBModel.dart';
import 'package:flutter/material.dart';

class QueryDatabase extends StatefulWidget {
  const QueryDatabase({Key? key}) : super(key: key);

  @override
  State<QueryDatabase> createState() => _QueryDatabaseState();
}

class _QueryDatabaseState extends State<QueryDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getQueryData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return displayData(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    });
              } else {
                return const Center(
                  child: Text("Data Not Found"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget displayData(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                data.address,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
