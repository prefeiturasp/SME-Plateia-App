import 'package:flutter/material.dart';
import 'package:sme_plateia/core/utils/colors.dart';
import 'package:sme_plateia/gen/assets.gen.dart';

class DropdownField<T> extends StatelessWidget {
  const DropdownField({
    super.key,
    required this.hintText,
    required this.buildItems,
    this.onChanged,
    this.value,
  });

  final String hintText;
  final List<DropdownMenuItem<T>>? Function() buildItems;
  final T? value;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColor.grayLighter,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          icon: Container(
            margin: EdgeInsets.all(16),
            child: Assets.icons.dropdown.svg(),
          ),
          isExpanded: true,
          items: buildItems(),
          value: value,
          hint: Text(
            hintText,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xffA4A4A4),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
