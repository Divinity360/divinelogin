import 'package:flutter/material.dart';
import 'package:foodybite_app/pallete.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
    this.validator,
    this.controller
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function validator;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.09,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),

          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 11, right: 3, top: 1, bottom: 5),
              errorStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, height: 0.3),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: kBodyText,
            ),
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
            validator: validator,
          ),
        ),
      ),
    );
  }
}
