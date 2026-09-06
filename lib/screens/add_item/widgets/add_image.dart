import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final ImagePicker _picker = ImagePicker();

  File? selectedImage;

  Future<void> showImagePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );

                  if (image != null) {
                    setState(() {
                      selectedImage = File(image.path);
                    });
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (image != null) {
                    setState(() {
                      selectedImage = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showImagePicker,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: BoxBorder.all(
            color: Colors.grey.shade400,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: selectedImage == null
            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo,
              size: 40,
            ),
            SizedBox(height: 8),
            Text('Add Image'),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            selectedImage!,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}