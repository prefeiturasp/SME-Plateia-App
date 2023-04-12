import 'package:flutter/material.dart';
import 'package:sme_plateia/core/utils/colors.dart';

class EventoTextField extends StatelessWidget {
  EventoTextField({
    super.key,
    this.hintText,
    this.onChanged,
  });

  final String? hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColor.grayLighter,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xffA4A4A4),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Color(0xff9D9D9C),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
