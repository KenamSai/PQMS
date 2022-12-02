import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class ImgPicker extends StatefulWidget {
  const ImgPicker({super.key});

  @override
  State<ImgPicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImgPicker> {
  File? _image;
  Future getImage(ImageSource type) async {
    final XFile? img = await ImagePicker().pickImage(source: type);
    // if (img == null) return;
    // final tempimg = File(img.path);
    setState(() {
      _image=File(img!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        _image != null
            ? GestureDetector(
                onTap: () async {
                  await getImage(ImageSource.camera);
                },
                child: Image.file(
                  _image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : GestureDetector(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: Icon(
                  Icons.camera_enhance,
                  size: 50,
                ),
              )
        // :CustomButton(
        //         ico: Icons.camera_alt_rounded,
        //         onclick: (() => getImage(ImageSource.camera))),
      ],
    );
  }
}

// ignore: non_constant_identifier_names
// Widget CustomButton(
//     {
       
//     required IconData ico,
//     required VoidCallback onclick}) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//        width: 60,
//       child: ElevatedButton(
//         onPressed: onclick,
//         child: Row(
//           children: [Icon(ico)],
//         ),
//       ),
//     ),
//   );
// }
