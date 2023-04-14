import 'package:formz/formz.dart';

enum EventoPeriodoError { invalid }

class EventoPeriodo extends FormzInput<String, EventoPeriodoError> {
  const EventoPeriodo.pure() : super.pure('');
  const EventoPeriodo.dirty([super.value = '']) : super.dirty();

  @override
  EventoPeriodoError? validator(String value) {
    return null;
  }
}
