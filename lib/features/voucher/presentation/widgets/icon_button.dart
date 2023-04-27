import 'package:flutter/material.dart';
import 'package:sme_plateia/core/utils/colors.dart';

class ButtonIconOutlinedWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? callback;
  final bool loading;

  const ButtonIconOutlinedWidget(
      {required this.title, required this.icon, this.loading = false, Key? key, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: callback,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: BorderSide(
                  color: TemaUtil.laranja01,
                  width: 2,
                ),
              ),
              child: loading
                  ? SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(strokeWidth: 2, color: TemaUtil.preto))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(icon, color: Colors.black),
                      ],
                    )),
        ],
      ),
    );
  }
}
