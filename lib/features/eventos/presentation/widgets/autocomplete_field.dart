import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:sme_plateia/core/utils/colors.dart';
import 'package:sme_plateia/shared/presentation/widgets/text_field_search.dart';

class AutocompleteField extends StatelessWidget {
  AutocompleteField({
    super.key,
    required this.hintText,
    this.suggestions,
    this.asyncSuggestions,
    this.onChanged,
    this.onSubmitted,
    this.controller,
  });

  final String hintText;
  final List<String>? suggestions;
  final Future<List<String>> Function(String)? asyncSuggestions;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;

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
      child: EasyAutocomplete(
        controller: controller,
        suggestions: suggestions,
        asyncSuggestions: asyncSuggestions,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        progressIndicatorBuilder: Center(
          child: CircularProgressIndicator(),
        ),
        inputTextStyle: TextStyle(fontSize: 14),
        suggestionTextStyle: TextStyle(fontSize: 14),
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
      ),
      // child: TextFieldSearch(
      //   initialList: [],
      //   controller: myController,
      //   label: hintText,
      //   textStyle: TextStyle(fontSize: 14),

      // ),
    );
  }
}
