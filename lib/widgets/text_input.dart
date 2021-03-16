import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget{
  EmailInput({this.labelText, this.prefixIcon});

  final String labelText;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: Constants.a7(context),
        child: TextField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Constants.black(context)
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: Constants.h3(context), vertical: Constants.v3(context)),
            filled: true,
            fillColor: Constants.lightGrey(context),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: Constants.m(context),
              color: Constants.grey(context)
            ),
            hintText: labelText,
            hintStyle: TextStyle(
              fontSize: Constants.m(context),
              color: Constants.grey(context)
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(40),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Icon(
                prefixIcon,
                color: Constants.black(context),
                size: 32 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1),)
            )
          )
        ),
      ),
    );
  }
}