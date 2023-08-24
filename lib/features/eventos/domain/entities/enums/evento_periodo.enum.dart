import 'package:sme_plateia/core/interfaces/i_dropdown_item.dart';

enum EnumEventoPeriodo implements IDropdownItem<EnumEventoPeriodo> {
  proximosEventos(1, 'Próximos eventos'),
  eventosPassados(0, 'Eventos passados');

  const EnumEventoPeriodo(this.ativo, this.nome);

  @override
  final String nome;
  final int ativo;

  @override
  List<EnumEventoPeriodo> get data => values;
}
