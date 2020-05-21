import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function onTap;
  final String text;
  final Widget trailingIcon;
  final String Function(String) validator;

  const InputField({
    Key key,
    @required this.onTap,
    @required this.text,
    @required this.trailingIcon,
    @required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Theme.of(context).accentColor),
    );
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).accentColor.withOpacity(0.5),
          //     blurRadius: 4,
          //   ),
          // ],
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: TextEditingController(text: text ?? ''),
          validator: validator,
          enabled: false,
          style: TextStyle(fontSize: 15),
          decoration: InputDecoration(
            suffixIcon: trailingIcon,
            disabledBorder: inputBorder,
            enabledBorder: inputBorder,
            errorBorder: inputBorder,
            errorStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            border: inputBorder,
          ),
        ),
      ),
    );
  }
}
