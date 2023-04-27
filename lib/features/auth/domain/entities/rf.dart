import 'package:formz/formz.dart';

enum RFValidationError { invalid }

class RF extends FormzInput<String, RFValidationError> {
  const RF.pure() : super.pure('');
  const RF.dirty([super.value = '']) : super.dirty();

  @override
  RFValidationError? validator(String value) {
    return isNumeric(value) || value.isEmpty ? null : RFValidationError.invalid;
  }
}

extension Explanation on RFValidationError {
  String? get nome {
    switch (this) {
      case RFValidationError.invalid:
        return 'RF inválido';
    }
  }
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
