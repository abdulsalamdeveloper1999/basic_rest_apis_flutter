import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/photos_model.dart';

class PhotosApiScreen extends StatefulWidget {
  const PhotosApiScreen({super.key});

  @override
  State<PhotosApiScreen> createState() => _PhotosApiScreenState();
}

class _PhotosApiScreenState extends State<PhotosApiScreen> {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotosApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photos = PhotosModel(
          title: i['title'],
          url: i['url'],
          id: i['id'],
        );
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPhotosApi(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return ListView.builder(
              itemCount: photosList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Notes id ${photosList[index].id}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      photosList[index].url,
                    ),
                  ),
                  subtitle: Text(photosList[index].title),
                );
              },
            );
          }
        },
      ),
    );
  }
}
