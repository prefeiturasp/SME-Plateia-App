import 'package:flutter/material.dart';

SnackBar snackBarWhenFailure({required String snackBarFailureText}) {
  return SnackBar(
    content: Center(child: Text(snackBarFailureText)),
    backgroundColor: Colors.red,
  );
}

SnackBar snackBarWhenSuccess({required String snackBarSuccessText}) {
  return SnackBar(
    content: Center(child: Text(snackBarSuccessText)),
    backgroundColor: Colors.green,
  );
}
