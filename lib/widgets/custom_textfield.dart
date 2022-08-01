import 'package:coinbid/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final String label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final TextInputType? textInputType;
  final bool? hideText;
  const CustomTextField({
    required this.controller,
    this.textInputType,
    required this.label,
    required this.validator,
    required this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.hideText,
    Key? key}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.black,
      obscureText: widget.hideText??false,
      keyboardType: widget.textInputType,
      onTap: (){
        setState(() {
          active = true;
        });
      },
      style: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.black
    ),
      validator: (value) => widget.validator(value),
      decoration: InputDecoration(
        hintText: widget.hintText,
        label: active == true ? Text(widget.label , style: GoogleFonts.nunito(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor
        ),):null,
        suffixIcon: widget.trailingIcon,
        prefix: widget.leadingIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 19,horizontal: 20),
        hintStyle: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xffB9B9BD)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffE1E1E5), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffE1E1E5), width: 1.0),
        ),
        focusColor: kBorderColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
