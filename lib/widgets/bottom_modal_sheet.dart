import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../constants/colors.dart';
import '../controllers/report_user_controller.dart';
import '../models/report_user_model.dart';

class ReportOptionsModal extends StatefulWidget {
  final String name;
  final String userUID;
  final String reportUserUID;

  ReportOptionsModal({required this.name, required this.userUID, required this.reportUserUID});

  @override
  _ReportOptionsModalState createState() => _ReportOptionsModalState();
}

class _ReportOptionsModalState extends State<ReportOptionsModal> {
  String? _selectedOption;
  final ReportUserController _reportUserController = Get.put(ReportUserController());

  List<Widget> _buildReportOptions() {
    final options = [
      'Inappropriate photos',
      'This is a fake account',
      'They\'re underage',
      'Doesn\'t match my search criteria',
      'They are abusive or harrassing',
      'They\'re soliciting me',
    ];

    return options.map((option) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: <Widget>[
            Radio<String>(
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
            SizedBox(width: 8),
            Text(
              option,
              style: TextStyle(
                fontFamily: 'SFProDisplay',
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Why are you reporting ${widget.name}?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Don't worry, we won't tell ${widget.name}",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(height: 8),
            ..._buildReportOptions(),
            SizedBox(height: 8),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedOption == null) {
                    Get.snackbar(
                      'Error',
                      'Please select an option',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    final reportUserModel = ReportUserModel(
                      userUID: widget.userUID,
                      reportUserUID: widget.reportUserUID,
                      reason: _selectedOption!,
                    );
                    bool success = await _reportUserController.reportUser(reportUserModel);
                    if (success) {
                      Navigator.pop(context);
                      Get.snackbar(
                        'Success',
                        'Report submitted successfully',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        'Failed to submit report',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                     Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0, // Remove shadow
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
                      "Let's go!",
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
            SizedBox(height: 8),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle report submission
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0, // Remove shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: gradientLeft,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: gradientLeft,
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
}
