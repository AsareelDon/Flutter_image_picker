import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker imageGetter = ImagePicker();
  List<XFile>? selectedPhotos = [];

  void askPermission() async {
    var response = await Permission.storage.status;
    if(response.isGranted){
      //Allow
      buildPhotos();
    }else{
      //Deny
      throw Exception("Storage access is ${response.isGranted}");
    }
  }
  void buildPhotos() async {
    final List<XFile> images = await imageGetter.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        selectedPhotos!.addAll(images);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.camera_viewfinder, size: 30,),
        titleSpacing: 0,
        centerTitle: false,
        title: const Text(
          "Photo Viewer",
          style: TextStyle(
            fontSize: 27,
            color: Colors.white,
            fontFamily: 'Ubuntu',
          ),
        ),
        elevation: 3,
      ),
      body: Center(
        child: Expanded(
          //gridview.builder is the best option in this situation but I think everyone in the class is using it.
          child: ListView.builder(
            padding: const EdgeInsets.all(7),
            itemCount: selectedPhotos!.length,
            itemBuilder: (context, imageCount) {
              return Image.file(File(selectedPhotos![imageCount].path), fit: BoxFit.cover);
            },
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 105,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          child: Row(
            children: const [
              Icon(CupertinoIcons.photo_on_rectangle),
              SizedBox(width: 7,),
              Text("Photo"),
            ],
          ),
          onPressed: () {
            askPermission();
            setState(() {});
          },
        ),
      ),
    );
  }
}
