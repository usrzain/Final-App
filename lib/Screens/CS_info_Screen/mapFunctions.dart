import 'package:flutter/material.dart';

class FilterChipBar extends StatefulWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onSelectionChanged;

  const FilterChipBar({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _FilterChipBarState createState() => _FilterChipBarState();
}

class _FilterChipBarState extends State<FilterChipBar> {
  int _selectedChipIndex = 0; // Internal state for selected chip

  @override
  void initState() {
    super.initState();
    _selectedChipIndex = widget.selectedIndex; // Initialize with provided index
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Add spacing between chips
      children: List.generate(widget.options.length, (index) {
        final isSelected = index == _selectedChipIndex;
        return ChoiceChip(
          label: Text(widget.options[index]),
          selected: isSelected,
          onSelected: (value) {
            setState(() {
              _selectedChipIndex = index;
              widget.onSelectionChanged(index); // Notify parent widget
            });
          },
        );
      }),
    );
  }
}
