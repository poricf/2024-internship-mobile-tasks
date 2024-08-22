import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? image;
  final VoidCallback onImagePick;

  const ImagePickerWidget({
    Key? key,
    required this.image,
    required this.onImagePick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width to make the widget responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double height = screenWidth > 600 ? 300 : 200;

    return GestureDetector(
      onTap: onImagePick,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(243, 243, 243, 1),
          borderRadius: BorderRadius.circular(8),
          image: image != null
              ? DecorationImage(
                  image: FileImage(image!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: image == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text('Upload Image'),
                ],
              )
            : null,
      ),
    );
  }
}

class FormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?) validator;

  const FormFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width to adjust padding/margins for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth > 600 ? 16.0 : 8.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: const Color.fromARGB(169, 216, 213, 213),
            ),
            validator: validator, // Add validation logic here
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // Auto-validate on typing
          ),
        ],
      ),
    );
  }
}
