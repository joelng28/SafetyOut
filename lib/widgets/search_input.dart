import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

TextEditingController emailController = TextEditingController();

class SearchInput extends StatelessWidget {
  SearchInput(
      {this.labelText,
      this.prefixIcon,
      this.onChanged,
      this.onSubmitted,
      this.focusNode});

  final String labelText;
  final IconData prefixIcon;
  final Function onChanged;
  final Function onSubmitted;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.a7(context),
      child: TextField(
          focusNode: focusNode,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          autocorrect: false,
          style: TextStyle(color: Constants.black(context)),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: Constants.h3(context)),
              filled: true,
              fillColor: Constants.trueWhite(context),
              labelText: labelText,
              labelStyle: TextStyle(
                  fontSize: Constants.m(context),
                  color: Constants.grey(context)),
              hintText: labelText,
              hintStyle: TextStyle(
                  fontSize: Constants.m(context),
                  color: Constants.grey(context)),
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
                child: SvgPicture.asset('assets/icons/loupe.svg',
                    color: Constants.grey(context),
                    height: 20 /
                        (MediaQuery.of(context).size.width < 380 ? 1.3 : 1)),
              ))),
    );
  }
}
