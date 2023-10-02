import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class ImageUploadApiScreen extends StatefulWidget {
  const ImageUploadApiScreen({super.key});

  @override
  State<ImageUploadApiScreen> createState() => _ImageUploadApiScreenState();
}

class _ImageUploadApiScreenState extends State<ImageUploadApiScreen> {
  File? image;
  final _picker = ImagePicker();
  bool isShowSpinner = false;

  Future<void> getImage() async {
    var pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      log('image pick fail');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      isShowSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = http.MultipartRequest('POST', uri);

    request.fields['title'] = 'Static title';

    var mulltiPart = http.MultipartFile(
      'image',
      stream,
      length,
    );

    request.files.add(mulltiPart);

    var response = await request.send();

    if (response.statusCode == 200) {
      log('Image Uploaded');
      setState(() {
        isShowSpinner = false;
      });
    } else {
      log('Image Upload failed');
      setState(() {
        isShowSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Upload Image'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isShowSpinner,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: getImage,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: image == null
                      ? const Icon(
                          Icons.upload,
                          color: Colors.white,
                        )
                      : Image.file(
                          File(image!.path).absolute,
                        ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: uploadImage,
                  child: const Text('Upload Image'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
