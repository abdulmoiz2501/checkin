import 'package:checkin/View/OtpScreen_Signup.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:checkin/services/auth_service.dart';
import '../constants/colors.dart';
import '../controllers/user_auth_controller.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final UserAuthController controller = Get.isRegistered<UserAuthController> ()? Get.find<UserAuthController>() : Get.put(UserAuthController());
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _selectedCountryCode = '+61';
  final AuthService _authService = AuthService();
  bool _isLoading = false;


  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      _selectedCountryCode = countryCode.dialCode!;
    });
  }

  String getFullPhoneNumber() {
    return '$_selectedCountryCode${_phoneController.text}';
  }


  void _showSnackbar(BuildContext context, String message, Color color) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _onSubmit() async {
    FocusScope.of(context).unfocus(); // Close the keyboard
    String phoneNumber = _phoneController.text;

    if (phoneNumber.isEmpty) {
      _showSnackbar(context, 'Please enter your phone number', Colors.red);
      return;
    } else if (!RegExp(r'^\d{4,14}$').hasMatch(phoneNumber)) {
      _showSnackbar(context, 'Phone number must be between 4 and 14 digits', Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });
    String fullPhoneNumber = getFullPhoneNumber();


    DatabaseReference ref = FirebaseDatabase.instance.ref('users/$fullPhoneNumber');
    DatabaseEvent event = await ref.once();

    if (event.snapshot.exists) {
      // Phone number already exists
      setState(() {
        _isLoading = false;
      });
      _showSnackbar(context, 'Number already exists, please log in.', Colors.red);
      return;
    }

    _authService.signUpWithPhoneNumber(fullPhoneNumber, (verificationId) {
      setState(() {
        _isLoading = false;
      });
      Get.to(() => OtpScreenSignUp(
        phoneNumber: fullPhoneNumber,
        verificationId: verificationId,
      ));
    });
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What is your number?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SFProDisplay',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CountryCodePicker(
                          onChanged: _onCountryChange,
                          initialSelection: 'AU',
                          showCountryOnly: false,
                          showFlag: true,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          showDropDownButton: true,
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'SFProDisplay',
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.all(0),
                          searchDecoration: const InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'SFProDisplay',
                              color: Colors.black,
                            ),
                          ),
                          flagDecoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          flagWidth: 30,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF909396)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF909396)),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF909396)),
                              ),

                            ),
                           /* validator: (value) {
                              if (value == null || value.isEmpty) {
                                _showSnackbar(context, 'Please enter your phone number', Colors.red);
                                return ''; // Return empty string to satisfy the validator
                              } else if (value.length != 10) {
                                _showSnackbar(context, 'Phone number must be 10 digits', Colors.red);
                                return ''; // Return empty string to satisfy the validator
                              }
                              return null;
                            },*/
                          ),

                        ),

                      ],
                    ),

                    Container(
                      width: 90,
                      height: 1,
                      color: Color(0xFF909396),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'You will receive an SMS verification that may apply message data rates.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF909396),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
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
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading ?
                CircularProgressIndicator(color: textInvertColor,)
                  :Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradientLeft, gradientRight],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Next",
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
