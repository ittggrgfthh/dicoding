import 'dart:io';

import 'package:storyapp/provider/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/upload_story.dart';

class AddStoryScreen extends StatefulWidget {
  final Function() onSend;
  const AddStoryScreen({super.key, required this.onSend});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final descriptionController = TextEditingController();
  XFile imagePicked = XFile("");
  String imagePath = '';

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Story', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => widget.onSend(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListView(
            children: [
              imagePath != ''
                  ? Image.file(File(imagePath.toString()), fit: BoxFit.contain)
                  : Container(
                      height: 200,
                      color: const Color.fromARGB(255, 226, 226, 226),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _onGalleryView((pickedImage, path) {
                      setState(() {
                        imagePicked = pickedImage;
                        imagePath = path;
                      });
                    }),
                    child: const Text("Gallery"),
                  ),
                  ElevatedButton(
                    onPressed: () => _onCameraView((pickedImage, path) {
                      setState(() {
                        imagePicked = pickedImage;
                        imagePath = path;
                      });
                    }),
                    child: const Text("Camera"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                maxLines: null, // Setting maxLines to null allows for unlimited lines
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter your details here...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  _onUpload((message) {});
                  widget.onSend();
                },
                child: const Text("Unggah"),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onGalleryView(Function(XFile pickedImage, String path) onGallery) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) onGallery(pickedFile, pickedFile.path);
  }

  _onUpload(Function(String msg) message) async {
    final storyProvider = context.read<StoryProvider>();

    if (descriptionController.text.isNotEmpty && imagePath != '' && imagePicked != XFile("")) {
      final uploadStory = UploadStory(
        description: descriptionController.text,
        bytes: File(imagePath.toString()).readAsBytesSync(),
        fileName: imagePath.toString().split('/').last,
      );

      final result = await storyProvider.createStory(uploadStory);
      message(result.message);
    }
  }

  _onCameraView(Function(XFile pickedImage, String path) onCamera) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      onCamera(pickedFile, pickedFile.path);
    }
  }
}
