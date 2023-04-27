import 'package:sme_plateia/core/interfaces/i_dropdown_item.dart';

enum EnumEventoPeriodo implements IDropdownItem<EnumEventoPeriodo> {
  todos(-1, 'Todos'),
  essaSemana(7, 'Essa semana'),
  esseMes(30, 'Esse mês');

  const EnumEventoPeriodo(this.dias, this.nome);

  @override
  final String nome;
  final int dias;

  @override
  List<EnumEventoPeriodo> get data => values;
}
