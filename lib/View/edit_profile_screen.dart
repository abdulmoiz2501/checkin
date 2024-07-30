import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/colors.dart';
import '../controllers/view_profile_controller.dart';
import '../widgets/clickable_square_tile.dart';
import '../widgets/gender_selection_tile.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/selectable_button.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  final ViewProfileController controller = Get.find();

  List<File?> _images = List<File?>.filled(4, null).obs;

  RxString selectedGender = 'Male'.obs;

  RxString selectedOption = ''.obs;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _images[index] = File(pickedFile.path);
/*      final directory = await getApplicationDocumentsDirectory();
      final String path = '${directory.path}/image_$index.png';
      final File localImage = await File(pickedFile.path).copy(path);
      _images[index] = localImage;*/
    }
  }

  List<String> _getImagePaths() {
    return _images
        .where((file) => file != null)
        .map((file) => file!.path)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    //print('this is the url of the image ${controller.images.value.first}');
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Photos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textBlackColor,
                fontFamily: 'SFProDisplay',
              ),
            ),
            Text(
              "Choose a clear, well-lit photos where your face is easily visible. It's your first impression, so make it count!",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A7D81),
                fontFamily: 'SFProDisplay',
              ),
            ).marginSymmetric(vertical: 5.0),
            SizedBox(
              height: 10.0,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, // Important for GridView inside SingleChildScrollView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
                childAspectRatio: 1.0,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Obx(() {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _pickImage(index);
                          setState(() {}); // Trigger a rebuild to show the selected image
                        },
                        child: _images[index] != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ), // Set the radius for rounded corners
                          child: Image.file(
                            _images[index]!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        )
                            : index < controller.images.length
                            ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ), // Set the radius for rounded corners
                          child: Image.network(
                            controller.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CustomCircularProgressIndicator()); // Display a loading indicator
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error); // Display an error icon
                            },
                          ),
                        )
                            : ClickableSquare(
                          onTap: () async {
                            await _pickImage(index);
                            setState(() {});
                          },
                        ),
                      ),
                      if (_images[index] != null)
                        Positioned(
                          bottom: MediaQuery.of(context).size.width * 0,
                          right: MediaQuery.of(context).size.width * 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _images[index] = null;
                              });
                            },
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Colors.red, // Background color
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.close, color: Colors.white, size: 16), // White cross icon
                              ),
                            ),
                          ),
                        ),
                      if (index < controller.images.length)
                        Positioned(
                          bottom: MediaQuery.of(context).size.width * 0,
                          right: MediaQuery.of(context).size.width * 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.images.removeAt(index);
                              }); // Trigger a rebuild to update the UI
                            },
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Colors.red, // Background color
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.close, color: Colors.white, size: 16), // White cross icon
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                });
              },
            ).marginSymmetric(vertical: 10.0),




            SizedBox(
              height: 15.0,
            ),
            Text(
              'What’s on your mind? (required)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textBlackColor,
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Sum up who you are in a single impactful sentence. Your tagline is your chance to make a memorable first impression — make it count.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A7D81),
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF7A7D81),
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: TextFormField(
                maxLines: 3,
                decoration: InputDecoration(

                    hintText:
                        'Write a sentence about yourself. For example: “Adventure seeker with a passion for exploring new horizons”',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7A7D81),
                      fontStyle: FontStyle.italic,
                      fontFamily: 'SFProDisplay',
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0)),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Gender (required)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textBlackColor,
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Select the gender that best represents who you are. Your choice is an important aspect of your identity, helping others understand and respect your individuality.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A7D81),
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(height: 10.0),
            GenderSelectionTile(
              title: 'Male',
              iconPath: 'assets/male.png', // Replace with your actual icon path
              isSelected: selectedGender.value == 'Male',
              onTap: () {
                selectedGender.value = 'Male';
              },
            ),
            GenderSelectionTile(
              title: 'Female',
              iconPath:
                  'assets/female.png', // Replace with your actual icon path
              isSelected: selectedGender == 'Female',
              onTap: () {
                selectedGender.value = 'Female';
              },
            ),
            GenderSelectionTile(
              title: 'Non Binary',
              iconPath:
                  'assets/binary.png', // Replace with your actual icon path
              isSelected: selectedGender.value == 'Non Binary',
              onTap: () {
                selectedGender.value = 'Non Binary';
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Height (optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textBlackColor,
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Enter your height to provide others with a better understanding of your physical stature. Whether you're towering above the crowd or perfectly petite, this detail adds depth to your profile.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A7D81),
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF7A7D81),
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Height in CM',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7A7D81),
                      fontStyle: FontStyle.italic,
                      fontFamily: 'SFProDisplay',
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0)),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Checkin Goals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textBlackColor,
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Let us know your intentions here. Your response will guide us in tailoring better recommendations for you.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A7D81),
                fontFamily: 'SFProDisplay',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Obx(
                () => SelectableButtonGroup(
                  options: [
                    'Friends',
                    'Networking',
                    'Dates',
                    'Casual',
                    'Love',
                    'Food',
                    'Explore city',
                    'Parties',
                    'Pub crawls',
                    'Drinking buddies'
                  ],
                  initialSelected: selectedOption.value,
                  onSelected: (value) {
                    selectedOption.value = value;
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sexual Orientation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textBlackColor,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
                Spacer(),
                Text(
                  'Show on profile',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7A7D81),
                    fontFamily: 'SFProDisplay',
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: true,
                    onChanged: (value) {
                      // _themeController.toggleTheme(value);
                    },
                    // value: isFirstSwitched.value,
                    // onChanged: (value) {
                    //   isFirstSwitched.value = value;
                    // },
                    // activeColor: greenColor,
                    inactiveThumbColor: textInvertColor,
                    inactiveTrackColor: textBlackColor,
                    activeTrackColor: textMainColor,
                  ),
                ),
              ],
            ),
            Text(
              'Share your sexual orientation to find connections that truly understand you.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A7D81),
                fontFamily: 'SFProDisplay',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Obx(
                () => SelectableButtonGroup(
                  options: [
                    'Straight',
                    'Gay',
                    'Lesbian',
                    'Bisexual',
                    'Asexual',
                    'Pansexual',
                    'Intersex',
                    'Other',
                    'Prefer not to say',
                  ],
                  initialSelected: selectedOption.value,
                  onSelected: (value) {
                    selectedOption.value = value;
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
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
                 // Get.to(()=> SubscriptionScreen());
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
                      "Save",
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
          ],
        ),
      ),
    );
  }

  Widget imagePickerCard(bool isCancel, int index) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                  child: isCancel == false
                      ? Icon(
                          Icons.add_circle,
                          size: 30.0,
                          color: Colors.black,
                        )
                      : null)),
        ),
        /*isCancel
            ? Positioned(
                bottom: MediaQuery.of(Get.context!).size.width * -0.03,
                right: MediaQuery.of(Get.context!).size.width * -0.03,

                child: *//*Image.asset(
                  'assets/circle-cancel.png',
                  height: 36,
                  width: 36,
                ),*//*
                IconButton(
                  icon: Icon(Icons.cancel, color: Colors.red,size: 30,),
                  onPressed: () {
                    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
                      content: Text('Image removed'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Add back the image
                          controller.images.removeAt(index);
                        },
                      ),
                    ));
                  },
                ) // Replace with your actual icon path
              )
            : SizedBox()*/
      ],
    );
  }
}