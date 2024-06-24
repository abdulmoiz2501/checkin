import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/colors.dart';
import '../widgets/clickable_square_tile.dart';
import 'AddNoteScreen.dart';
import 'dart:io';

class AddPicturesScreen extends StatefulWidget {
  final String uid;
  final String name;
  final int age;
  final String gender;
  final String sexuality;

  const AddPicturesScreen({
    Key? key,
    required this.uid,
    required this.name,
    required this.age,
    required this.gender,
    required this.sexuality,
  }) : super(key: key);

  @override
  State<AddPicturesScreen> createState() => _AddPicturesScreenState();
}

class _AddPicturesScreenState extends State<AddPicturesScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File?> _images = List<File?>.filled(4, null);
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
      });
    }
  }
  List<String> _getImagePaths() {
    return _images.where((file) => file != null).map((file) => file!.path).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/back_arrow.png'),
          ),
          onPressed: () {
            Get.back();
            print("Leading icon pressed");
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.053),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add your recent pictures',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: textBlackColor,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    'No nudity allowed, We will ban you for life!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _pickImage(index);
                          },
                          child: _images[index] != null
                              ? Image.file(_images[index]!, fit: BoxFit.cover)
                              : ClickableSquare(
                                  onTap: () {
                                    _pickImage(index);
                                    print('Square $index tapped');
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [gradientLeft, gradientRight],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  List<String> imagePaths = _getImagePaths();
                  if(imagePaths.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select atleast one image.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  else{
                    Get.to(() => AddNoteScreen(
                      uid: widget.uid,
                      name: widget.name,
                      age: widget.age,
                      gender: widget.gender,
                      sexuality: widget.sexuality,
                      imagePaths: imagePaths,
                    ));
                    print("Next pressed");
                    print('User ID: ${widget.uid}');
                    print('Name: ${widget.name}');
                    print('Age: ${widget.age}');
                    print('gender: ${widget.gender}');
                    print('sexuality: ${widget.sexuality}');
                    print('Image paths: $imagePaths');
                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradientLeft, gradientRight],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Next ",
                      style: TextStyle(
                        color: textInvertColor,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
