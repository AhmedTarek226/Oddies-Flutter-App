import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final Function onClick;
  final bool readonly;
  final String initvalue;
  CustomTextField(
      {this.onClick,
      @required this.icon,
      @required this.hint,
      this.readonly = false,
      this.initvalue});

  String validate(String hint) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email':
        return 'Email is empty !';
      case 'Enter your password':
        return 'Password is empty !';
      case 'Product Name':
        return 'Name is empty !';
      case 'Product Price':
        return 'Price is empty !';
      case 'Product Description':
        return 'Description is empty !';
      case 'Product Category':
        return 'Category is empty !';
      case 'Image location':
        return 'Location is empty !';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        readOnly: readonly,
        validator: (value) {
          if (value.isEmpty) {
            return validate(hint);
            // ignore: missing_return
          }
        },
        initialValue: initvalue,
        style: TextStyle(fontSize: 20),
        onSaved: onClick,
        obscureText: hint == 'Enter your password' ? true : false,
        cursorColor: Colors.yellow[700],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
          prefixIcon: Icon(
            icon,
            size: 20,
            color: Colors.yellow[700],
          ),
          filled: true,
          fillColor: Color(0xFFFFE6AC),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}
