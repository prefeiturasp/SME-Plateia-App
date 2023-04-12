import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/presentation/cubits/filtro/filtro_cubit.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/dropdown_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/autocomplete_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/evento_card.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/evento_text_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/scroll_column_expandable.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/sem_eventos.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/sem_resultados.dart';
import 'package:sme_plateia/injector.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';
import 'package:sme_plateia/shared/presentation/widgets/rodape.dart';

@RoutePage()
class EventosPage extends StatefulWidget {
  const EventosPage({super.key});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(),
      body: BlocProvider(
        create: (context) => FiltroCubit(sl()),
        child: ScrollColumnExpandable(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFiltros(),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16, top: 24),
              child: Text(
                'Resultados de busca por "Essa semana"',
                style: TextStyle(
                  color: Color(0xffC25F14),
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: _buildSemEventos(),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          _buildFiltros(),
          BlocBuilder<FiltroCubit, FiltroState>(
            builder: (context, state) {
              switch (state.pageStatus) {
                case PageStatus.carregando:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case PageStatus.semEventos:
                  return _buildSemEventos();
                case PageStatus.comResultado:
                  return _buildEventos(state.resultado);
                case PageStatus.semResultado:
                  return _buildSemResultados();
                default:
                  return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  _buildEventos(List<EventoResumo> resultado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 48),
        _biuldResult(),
      ],
    );
  }

  _buildFiltros() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            "Encontre seu evento",
            style: TextStyle(
              color: Color(0xffC25F14),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildForm(),
        ],
      ),
    );
  }

  _buildForm() {
    return Column(
      children: [
        EventoTextField(
          hintText: 'Busque pelo nome do evento',
        ),
        SizedBox(
          height: 16,
        ),
        DropdownField<EnumEventoPeriodo>(
          hintText: 'Selecione o período',
          buildItems: () {
            return EnumEventoPeriodo.values.map<DropdownMenuItem<EnumEventoPeriodo>>((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value.nome),
              );
            }).toList();
          },
        ),
        const SizedBox(
          height: 16,
        ),
        AutocompleteField(
          hintText: 'Busque pelo local do evento',
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Buscar'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  _biuldResult() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return EventoCard();
      },
    );
  }

  _buildSemEventos() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        color: Color(0xffFBF2D0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SemEventos(),
            ),
            Rodape(),
          ],
        ),
      ),
    );
  }

  _buildSemResultados() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        color: Color(0xffFBF2D0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SemResultados(),
            ),
            Rodape(),
          ],
        ),
      ),
    );
  }
}
