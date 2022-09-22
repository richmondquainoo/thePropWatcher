import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T) onChanged;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            labelText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            isDense: true,
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                    getLabel(value),
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
