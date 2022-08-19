import 'package:contact_app/dbHelper/mongodb.dart';
import 'package:contact_app/model/mongoDBModel.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mo;

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({Key? key}) : super(key: key);

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  var _checkInsertUpdate = "Insert";

  @override
  Widget build(BuildContext context) {
    MongoDbModel? data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel?;

    // ignore: unnecessary_null_comparison
    if (data != null) {
      _nameController.text = data.name;
      _addressController.text = data.address;
      _checkInsertUpdate = "Update";
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                _checkInsertUpdate,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _addressController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _fakeData();
                      },
                      child: const Text("Generate Data")),
                  ElevatedButton(
                      onPressed: () {
                        if (_checkInsertUpdate == "Update") {
                          _updateData(data?.id, _nameController.text,
                              _addressController.text);
                        } else {
                          _insertData(
                              _nameController.text, _addressController.text);
                        }
                      },
                      child: Text(_checkInsertUpdate))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateData(var id, String name, String address) async {
    final updateData = MongoDbModel(id: id, name: name, address: address);
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
  }

  Future<void> _insertData(String name, String address) async {
    var id = mo.ObjectId();
    final data = MongoDbModel(id: id, name: name, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted ID${id.$oid}")));
    _clearAll();
  }

  void _clearAll() {
    _nameController.text = "";
    _addressController.text = "";
  }

  void _fakeData() {
    setState(() {
      _nameController.text = faker.person.name();
      _addressController.text =
          "${faker.address.streetName()}\n${faker.address.streetAddress()}";
    });
  }
}
