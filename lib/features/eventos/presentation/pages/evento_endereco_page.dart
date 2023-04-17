import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';

@RoutePage()
class EventoEnderecoPage extends HookWidget {
  final int eventoId;
  final String endereco;
  const EventoEnderecoPage({
    Key? key,
    @PathParam('id') required this.eventoId,
    required this.endereco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho('titulo'),
      body: Container(),
    );
  }
}
