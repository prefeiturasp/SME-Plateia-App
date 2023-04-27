import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hookified_infinite_scroll_pagination/hookified_infinite_scroll_pagination.dart';

import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/presentation/cubits/autocomplete_local/autocomplete_local_cubit.dart';
import 'package:sme_plateia/features/eventos/presentation/cubits/filtro/filtro_cubit.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/autocomplete_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/dropdown_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/evento_card.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/evento_text_field.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/sem_eventos.dart';
import 'package:sme_plateia/features/eventos/presentation/widgets/sem_resultados.dart';
import 'package:sme_plateia/injector.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';
import 'package:sme_plateia/shared/presentation/widgets/rodape.dart';

@RoutePage()
class EventosPage extends HookWidget {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filtroCubit = BlocProvider.of<FiltroCubit>(context);
    final pagingController = usePagingController<int, EventoResumo>(
      firstPageKey: 1,
      onPageRequest: (pageKey, pagingController) {
        filtroCubit.requestMoreDate(pageKey: pageKey, pagingController: pagingController);
      },
    );

    final controllerNomeEvento = useTextEditingController();
    final controllerLocalEvento = useTextEditingController();

    useEffect(() {
      FlutterNativeSplash.remove();
      return pagingController.dispose;
    }, const []);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutocompleteLocalCubit(sl())),
      ],
      child: Scaffold(
        appBar: Cabecalho('Meus Eventos'),
        body: CustomScrollView(
          slivers: [
            // Formulario de filtro
            _buildFormularioFiltro(context, controllerNomeEvento, controllerLocalEvento, pagingController),

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

            SliverPadding(
              padding: EdgeInsets.only(top: 16, right: 16, left: 16),
              sliver: PagedSliverList<int, EventoResumo>(
                pagingController: pagingController,
                shrinkWrapFirstPageIndicators: true,
                builderDelegate: PagedChildBuilderDelegate<EventoResumo>(
                  noItemsFoundIndicatorBuilder: (context) {
                    return Container();
                  },
                  itemBuilder: (context, item, index) {
                    return EventoCard(
                      item,
                      onTap: () {
                        context.pushRoute(EventoDetalhesRoute(
                          key: Key(item.id.toString()),
                          idEvento: item.id,
                        ));
                      },
                    );
                  },
                ),
              ),
            ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocBuilder<FiltroCubit, FiltroState>(
                builder: (context, state) {
                  switch (state.pageStatus) {
                    case EnumPageStatus.semResultado:
                      if (state.resultadoNomeBusca.isEmpty) {
                        return _buildSemEventos();
                      } else {
                        return _buildSemResultados();
                      }
                    default:
                      return Rodape();
                  }
                },
              ),
            ),
          ],
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

  Widget _buildSemEventos() {
    return Container(
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
    );
  }

  Widget _buildSemResultados() {
    return Container(
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
    );
  }

  _buildFormularioFiltro(
    BuildContext context,
    TextEditingController controllerNomeEvento,
    TextEditingController controllerLocalEvento,
    PagingController<int, EventoResumo> pagingController,
  ) {
    return SliverToBoxAdapter(
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
                    context.read<FiltroCubit>().requestMoreDate(
                          pagingController: pagingController,
                          resetFilter: true,
                        );
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
                    context.read<FiltroCubit>().requestMoreDate(
                          pagingController: pagingController,
                          resetFilter: true,
                        );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
