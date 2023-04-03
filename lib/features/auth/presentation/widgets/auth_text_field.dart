import 'package:flutter/material.dart';
import 'package:sme_plateia/core/utils/colors.dart';

class AuthTextField extends StatefulWidget {
  final String hint;
  final String labelText;
  final ValueChanged<String> onChanged;
  final void Function()? onEditingComplete;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final bool isRequiredField;
  final String? error;
  final bool showError;
  final bool hasError;
  final EdgeInsets padding;
  final Iterable<String>? autofillHints;

  const AuthTextField({
    Key? key,
    this.hint = '',
    this.labelText = '',
    required this.onChanged,
    this.onEditingComplete,
    required this.keyboardType,
    this.isPasswordField = false,
    this.isRequiredField = false,
    this.error,
    this.showError = true,
    this.hasError = false,
    this.autofillHints,
    this.padding = const EdgeInsets.only(left: 15, right: 15, top: 5),
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InputBorder borderNone = InputBorder.none;

    BoxBorder inputBorder = Border.all(
      color: Colors.transparent,
    );

    BoxBorder inputBorderError = Border.all(
      color: TemaUtil.vermelhoErro,
    );

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(15, 51, 51, 51),
            borderRadius: BorderRadius.circular(12.0),
            border: widget.error != null || widget.hasError ? inputBorderError : inputBorder,
          ),
          padding: widget.padding,
          child: TextFormField(
            keyboardType: widget.keyboardType,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              suffixIcon: widget.isPasswordField
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: TemaUtil.cinza,
                      ),
                    )
                  : null,
              fillColor: Colors.white,
              labelText: widget.isRequiredField ? '${widget.labelText}*' : widget.labelText,
              labelStyle: TextStyle(
                color: widget.error != null || widget.hasError ? TemaUtil.vermelhoErro : TemaUtil.preto01,
              ),
              hintText: widget.isRequiredField ? '${widget.hint}*' : widget.hint,
              border: borderNone,
              disabledBorder: borderNone,
              enabledBorder: borderNone,
              errorBorder: borderNone,
              errorText: widget.showError ? widget.error : null,
              errorStyle: TextStyle(color: TemaUtil.vermelhoErro),
            ),
            autocorrect: false,
            textInputAction: TextInputAction.done,
            obscureText: _obscureText,
            maxLines: 1,
            onChanged: widget.onChanged,
            autofillHints: widget.autofillHints,
            onEditingComplete: widget.onEditingComplete,
          ),
        ),
      ],
    );
  }
}
