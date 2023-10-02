import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/users_model_complex.dart';

class UsersApiComplexScreen extends StatefulWidget {
  const UsersApiComplexScreen({super.key});

  @override
  State<UsersApiComplexScreen> createState() => _UsersApiComplexScreenState();
}

class _UsersApiComplexScreenState extends State<UsersApiComplexScreen> {
  List<UsersModelComplex> usersList = [];

  Future<List<UsersModelComplex>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        usersList.add(UsersModelComplex.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUsers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        resuableRow(
                          key: 'User ID',
                          value: usersList[index].id!.toString(),
                        ),
                        resuableRow(
                          key: 'Name',
                          value: usersList[index].name!,
                        ),
                        resuableRow(
                          key: 'username',
                          value: usersList[index].username!,
                        ),
                        resuableRow(
                          key: 'email',
                          value: usersList[index].email!,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            'Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        resuableRow(
                          key: 'city',
                          value: usersList[index].address!.city!,
                        ),
                        resuableRow(
                          key: 'street',
                          value: usersList[index].address!.street!,
                        ),
                        resuableRow(
                          key: 'suite',
                          value: usersList[index].address!.suite!,
                        ),
                        resuableRow(
                          key: 'zipcode',
                          value: usersList[index].address!.zipcode!,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            'Geo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        resuableRow(
                          key: 'latitude',
                          value: usersList[index].address!.geo!.lat!,
                        ),
                        resuableRow(
                          key: 'longitude ',
                          value: usersList[index].address!.geo!.lng!,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            'Contacts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        resuableRow(
                          key: 'phone',
                          value: usersList[index].phone!,
                        ),
                        resuableRow(
                          key: 'website',
                          value: usersList[index].website!,
                        ),
                        resuableRow(
                          key: 'company Name',
                          value: usersList[index].company!.name!,
                        ),
                        resuableRow(
                          key: 'catchPhrase',
                          value: usersList[index].company!.catchPhrase!,
                        ),
                        resuableRow(
                          key: 'bs',
                          value: usersList[index].company!.bs!,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Row resuableRow({required String key, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(key),
        Text(value),
      ],
    );
  }
}
