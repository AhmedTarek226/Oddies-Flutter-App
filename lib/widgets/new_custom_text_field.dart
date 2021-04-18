import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class NewCustomTextField extends StatelessWidget {
  NewCustomTextField(
      {@required this.label,
      @required this.onClick,
      this.readonly = false,
      this.initvalue});
  final String label;
  final Function onClick;
  final bool readonly;
  final String initvalue;

  String validate(String label) {
    switch (label) {
      case 'Name':
        return 'Name is empty !';
      case 'Email':
        return 'Email is empty !';
      case 'Password':
        return 'Password is empty !';
      case 'Phone Number':
        return 'Phone Number is empty !';
      case 'Product Name':
        return 'Name is empty !';
      case 'Product Price':
        return 'Price is empty !';
      case 'Product Description':
        return 'Description is empty !';
      case 'Product Category':
        return 'Category is empty !';
      case 'Address':
        return 'Address is empty !';
      case 'Flat number (Address Details)':
        return 'Address Details is empty !';
      default: return 'This field is required';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.grey[400],
        accentColor: Colors.grey[400],
        errorColor: Colors.red[500],
      ),
      child: TextFormField(
          readOnly: readonly,
          validator: (value) {
            if (value.isEmpty) {
              return validate(label);
              // ignore: missing_return
            }
            else{
              return null;
            }
          },
          obscureText: label == 'Password' ? true : false,
          initialValue: initvalue,
          onSaved: onClick,
          cursorColor: Colors.blueGrey,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            labelText: label,
            //  filled: true,
            fillColor: KMainColor,
            labelStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: height * .023,
            ),
          )),
    );
  }
}
