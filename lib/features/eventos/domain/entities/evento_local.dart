import 'package:formz/formz.dart';

enum EventoLocalError { invalid }

class EventoLocal extends FormzInput<String, EventoLocalError> {
  const EventoLocal.pure() : super.pure('');
  const EventoLocal.dirty([super.value = '']) : super.dirty();

  @override
  EventoLocalError? validator(String value) {
    return null;
  }
}
