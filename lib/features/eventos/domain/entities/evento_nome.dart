import 'package:formz/formz.dart';

enum EventoNomeError { invalid }

class EventoNome extends FormzInput<String, EventoNomeError> {
  const EventoNome.pure() : super.pure('');
  const EventoNome.dirty([super.value = '']) : super.dirty();

  @override
  EventoNomeError? validator(String value) {
    return null;
  }
}
