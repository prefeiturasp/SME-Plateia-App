import 'package:formz/formz.dart';

enum SenhaValidationError { empty }

class Senha extends FormzInput<String, SenhaValidationError> {
  const Senha.pure() : super.pure('');
  const Senha.dirty([super.value = '']) : super.dirty();

  @override
  SenhaValidationError? validator(String value) {
    return null;
  }
}

extension Explanation on SenhaValidationError {
  String? get nome {
    switch (this) {
      case SenhaValidationError.empty:
        return 'Digite a senha';
    }
  }
}
