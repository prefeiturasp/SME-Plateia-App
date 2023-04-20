import 'package:flutter/material.dart';
import 'package:sme_plateia/core/utils/colors.dart';
import 'package:sme_plateia/gen/assets.gen.dart';

class EventoTextField extends StatelessWidget {
  EventoTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

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
        style: TextStyle(
          fontSize: 14,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 16),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xffA4A4A4),
          ),
          suffixIcon: Container(
            margin: EdgeInsets.all(16),
            child: Assets.icons.procurar.svg(),
          ),
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
