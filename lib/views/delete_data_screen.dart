import 'package:contact_app/dbHelper/mongodb.dart';
import 'package:contact_app/model/mongoDBModel.dart';
import 'package:flutter/material.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({Key? key}) : super(key: key);

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return _dataCard(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    });
              } else {
                return const Center(
                  child: Text("No Data Found"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _dataCard(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(data.name),
                  const SizedBox(height: 10),
                  _text(data.address),
                  const SizedBox(height: 10),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    await MongoDatabase.delete(data);
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(String value) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
