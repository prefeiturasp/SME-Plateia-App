import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sme_plateia/core/extensions/scroll_controller_extensions.dart';
import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/presentation/cubits/filtro/filtro_cubit.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/dropdown_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/autocomplete_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/evento_card.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/evento_text_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/sem_eventos.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/sem_resultados.dart';
import 'package:sme_plateia/injector.dart';
import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/shared/presentation/widgets/text_button.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';
import 'package:sme_plateia/shared/presentation/widgets/rodape.dart';

import '../cubits/autocomplete_local/autocomplete_local_cubit.dart';

@RoutePage()
class EventosPage extends HookWidget {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filtroCubit = BlocProvider.of<FiltroCubit>(context);
    final scrollController = useScrollController();

    final controllerNomeEvento = useTextEditingController();
    final controllerLocalEvento = useTextEditingController();

    useEffect(() {
      FlutterNativeSplash.remove();
      filtroCubit.carregarEventos();

      scrollController.onScrollEndsListener(() {
        debugPrint('Carregando mais dados');
        filtroCubit.carregarEventos(filtro: true);
      });

      return scrollController.dispose;
    }, const []);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutocompleteLocalCubit(sl())),
      ],
      child: Scaffold(
        appBar: Cabecalho(),
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            // Formulario de filtro
            SliverToBoxAdapter(
              child: Padding(
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
                    Column(
                      children: [
                        EventoTextField(
                          hintText: 'Busque pelo nome do evento',
                          controller: controllerNomeEvento,
                          onChanged: (nome) {
                            context.read<FiltroCubit>().changeNomeEvento(nome);
                          },
                          onSubmitted: (value) {
                            context.read<FiltroCubit>().carregarEventos(filtro: true);
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<FiltroCubit, FiltroState>(
                          builder: (context, state) {
                            return DropdownField<EnumEventoPeriodo>(
                              hintText: 'Selecione o período',
                              value: state.periodoEvento,
                              buildItems: () {
                                return EnumEventoPeriodo.values.map<DropdownMenuItem<EnumEventoPeriodo>>((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.nome, style: TextStyle(fontSize: 14)),
                                  );
                                }).toList();
                              },
                              onChanged: (value) {
                                context.read<FiltroCubit>().changePeriodoEvento(value!);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<AutocompleteLocalCubit, AutocompleteLocalState>(
                          builder: (context, state) {
                            return AutocompleteField(
                              controller: controllerLocalEvento,
                              hintText: 'Busque pelo local do evento',
                              // suggestions: state.locais,
                              asyncSuggestions: (value) async {
                                return state.locais;
                              },
                              onChanged: (value) {
                                context.read<AutocompleteLocalCubit>().buscarLocal(value);
                              },
                              onSubmitted: (value) {
                                context.read<FiltroCubit>().changeLocalEvento(value);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          child: Text(
                            'Buscar'.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            context.read<FiltroCubit>().carregarEventos(filtro: true);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Texto de filtro
            SliverToBoxAdapter(
              child: BlocBuilder<FiltroCubit, FiltroState>(
                builder: (context, state) {
                  switch (state.pageStatus) {
                    case EnumPageStatus.comResultado:
                    case EnumPageStatus.semResultado:
                      if (state.resultadoNomeBusca.isNotEmpty) {
                        return _buildTituloBusca(state.resultadoNomeBusca);
                      } else {
                        return SizedBox.shrink();
                      }

                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            ),
            // Lista de resultados
            BlocBuilder<FiltroCubit, FiltroState>(
              builder: (context, state) {
                switch (state.pageStatus) {
                  case EnumPageStatus.comResultado:
                    return _buildEventos(state.resultado);
                  default:
                    return SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
                }
              },
            ),

            // Sinal de carregando mais dados
            SliverToBoxAdapter(
              child: BlocBuilder<FiltroCubit, FiltroState>(
                builder: (context, state) {
                  if (!state.noMoreData) {
                    return Padding(
                      padding: EdgeInsets.only(top: 14, bottom: 32),
                      child: CupertinoActivityIndicator(),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),

            // Sem Resultado
            BlocBuilder<FiltroCubit, FiltroState>(
              builder: (context, state) {
                switch (state.pageStatus) {
                  case EnumPageStatus.carregando:
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case EnumPageStatus.semResultado:
                    if (state.resultadoNomeBusca.isEmpty) {
                      return SliverFillRemaining(
                        child: _buildSemEventos(),
                      );
                    } else {
                      return SliverFillRemaining(
                        child: _buildSemResultados(),
                      );
                    }
                  default:
                    return SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
                }
              },
            ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Rodape()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildEventos(
    List<EventoResumo> eventos,
  ) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => EventoCard(
            eventos[index],
            onTap: () {
              context.pushRoute(VoucherRoute(voucherId: '41584'));
            },
          ),
          childCount: eventos.length,
        ),
      ),
    );
  }

  Widget _buildTituloBusca(String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16, top: 24),
      child: Text(
        'Resultados de busca por "$value"',
        style: TextStyle(
          color: Color(0xffC25F14),
          fontSize: 14,
        ),
      ),
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
