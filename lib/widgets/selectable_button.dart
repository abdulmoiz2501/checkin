import 'package:flutter/material.dart';

class SelectableButtonGroup extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onSelected;
  final String initialSelected;

  SelectableButtonGroup({
    required this.options,
    required this.onSelected,
    this.initialSelected = '',
  });

  @override
  _SelectableButtonGroupState createState() => _SelectableButtonGroupState();
}

class _SelectableButtonGroupState extends State<SelectableButtonGroup> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5.0,
      runSpacing: 2.0,
      children: widget.options.map((option) {
        bool isSelected = selectedOption == option;
        return ElevatedButton(
          onPressed: () {
            setState(() {
              selectedOption = option;
            });
            widget.onSelected(option);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : Colors.black, backgroundColor: isSelected ? Colors.black : Colors.white,
            side: BorderSide(color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(option),
        );
      }).toList(),
    );
  }
}
