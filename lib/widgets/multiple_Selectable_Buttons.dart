import 'package:flutter/material.dart';

class MultipleSelectableButtons extends StatefulWidget {
  final List<String> options;
  final ValueChanged<List<String>> onSelected;
  final List<String>? initialSelected;
  final bool tappable;

  MultipleSelectableButtons({
    required this.options,
    required this.onSelected,
    this.initialSelected = const [],
    this.tappable = true,
  });

  @override
  _MultipleSelectableButtonsState createState() =>
      _MultipleSelectableButtonsState();
}

class _MultipleSelectableButtonsState extends State<MultipleSelectableButtons> {
  List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    selectedOptions =
        widget.initialSelected != null ? widget.initialSelected! : [];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 5.0,
      runSpacing: 2.0,
      children: widget.options.map((option) {
        bool isSelected = selectedOptions.contains(option);
        return ElevatedButton(
          onPressed: () {
            if (widget.tappable) {
              setState(() {
                if (isSelected) {
                  selectedOptions.remove(option);
                } else {
                  selectedOptions.add(option);
                }
              });
            }
            widget.onSelected(selectedOptions);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : Colors.black,
            backgroundColor: isSelected ? Colors.black : Colors.white,
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
