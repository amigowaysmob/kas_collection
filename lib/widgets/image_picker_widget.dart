import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kascollection/utils/constant.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool isBottomSheetVisible = false; // Add this variable
  String? _imagePath;
  final picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final image = await picker.pickImage(source: source);
    if (image == null) return;

    setState(() {
      _imagePath = image.path;
    });
  }

  Future<void> showImagePickerOptions(BuildContext context) async {
    setState(() {
      isBottomSheetVisible = !isBottomSheetVisible; // Toggle the visibility
    });

    if (isBottomSheetVisible) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pop(context); // Close the bottom sheet if it's already open
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height:80,
          width: 80,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage:
                      _imagePath != null ? FileImage(File(_imagePath!)) : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: -30,
                child: RawMaterialButton(
                  onPressed: () {
                    showImagePickerOptions(context);
                  },
                  elevation: 2.0,
                  fillColor: const Color(0xFFF5F6F9),
                  padding: const EdgeInsets.all(
                    .0),
                  shape: const CircleBorder(),
                  child: Icon(Icons.add_a_photo_outlined, color: appColor,),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        // You can show a loading indicator while capturing the photo
        );
  }
}
