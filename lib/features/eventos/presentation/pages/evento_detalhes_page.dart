import 'package:auto_route/auto_route.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/core/extensions/datetime_extension.dart';
import 'package:sme_plateia/core/extensions/int_extensions.dart';
import 'package:sme_plateia/core/utils/colors.dart';
import 'package:sme_plateia/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';
import 'package:sme_plateia/features/eventos/presentation/cubits/evento_detalhes/evento_detalhes_cubit.dart';
import 'package:sme_plateia/gen/assets.gen.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';
import 'package:sme_plateia/shared/presentation/widgets/rodape.dart';

@RoutePage()
class EventoDetalhesPage extends HookWidget {
  final int idEvento;

  const EventoDetalhesPage({
    super.key,
    @PathParam('id') required this.idEvento,
  });

  @override
  Widget build(BuildContext context) {
    final eventoDetalhesCubit = BlocProvider.of<EventoDetalhesCubit>(context);

    useEffect(() {
      eventoDetalhesCubit.carregarDetalhes(idEvento);

      return null;
    }, const []);

    return Scaffold(
      appBar: Cabecalho('Evento'),
      body: BlocBuilder<EventoDetalhesCubit, EventoDetalhesState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (eventoDetalhes) {
              return SingleChildScrollView(
                child: _buildDetalhes(context, eventoDetalhes),
              );
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            orElse: () => SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildDetalhes(BuildContext context, EventoDetalhes eventoDetalhes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(context, eventoDetalhes),
        _buildResumo(context, eventoDetalhes),
        _buildInformacoes(eventoDetalhes),
        Center(
          child: Rodape(),
        ),
      ],
    );
  }

  _buildImage(BuildContext context, EventoDetalhes eventoDetalhes) {
    return FastCachedImage(
      url: eventoDetalhes.urlPoster,
      fit: BoxFit.cover,
      height: 196,
      width: MediaQuery.of(context).size.height,
      errorBuilder: (context, error, stackTrace) {
        return Assets.images.eventoGenerico.image(
          fit: BoxFit.cover,
        );
      },
    );
  }

  _buildResumo(BuildContext context, EventoDetalhes eventoDetalhes) {
    return Container(
      color: Color(0xffF2F1EF),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            eventoDetalhes.nome,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          _buildDataHora(eventoDetalhes),
          const SizedBox(
            height: 16,
          ),
          _buildLocalizacao(context, eventoDetalhes),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              String nome = '';
              String rf = '';

              state.mapOrNull(
                authenticated: (value) {
                  var nomeCompleto = value.usuario.usuario.nome.split(' ');
                  nome = '${nomeCompleto.first} ${nomeCompleto.last}';
                  rf = value.usuario.usuario.rf;
                },
              );

              return TextButton(
                onPressed: () {
                  context.pushRoute(VoucherRoute(
                    inscricaoId: eventoDetalhes.inscricaoId,
                    inscricaoData: eventoDetalhes.inscricaoData,
                    eventoNome: eventoDetalhes.nome,
                    ingressosPorMembro: eventoDetalhes.numeroDeTicket,
                    local: eventoDetalhes.local,
                    endereco: eventoDetalhes.endereco,
                    dataHora: eventoDetalhes.dataHora,
                    userRF: rf,
                    userNome: nome,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Voucher'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  _buildDataHora(EventoDetalhes eventoDetalhes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Assets.icons.calendario.svg(width: 16),
            SizedBox(width: 8),
            Text(eventoDetalhes.dataHora.formatddMMyyy()),
          ],
        ),
        SizedBox(width: 24),
        Row(
          children: [
            Assets.icons.relogio.svg(width: 16),
            SizedBox(width: 8),
            Text(eventoDetalhes.dataHora.formatHHmm()),
          ],
        ),
        Container(),
      ],
    );
  }

  _buildLocalizacao(BuildContext context, EventoDetalhes eventoDetalhes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Assets.icons.local.svg(width: 16),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventoDetalhes.local,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                eventoDetalhes.endereco,
                maxLines: 3,
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.orangeDarkest,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'Ver Mapa'.toUpperCase(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ),
                onTap: () {
                  context.pushRoute(EventoEnderecoRoute(
                    eventoId: eventoDetalhes.id,
                    endereco: eventoDetalhes.endereco,
                    local: eventoDetalhes.local,
                  ));
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildInformacoes(EventoDetalhes eventoDetalhes) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mais informações',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.orangeDarkest,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gênero:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      eventoDetalhes.genero,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Classificação:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      eventoDetalhes.classificacao,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: Row(
                  children: [
                    Text(
                      'Ingressos: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      eventoDetalhes.numeroDeTicket.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 6,
                child: Row(
                  children: [
                    Text(
                      'Duração: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      eventoDetalhes.duracao.toMMSS,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Sintese',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            eventoDetalhes.sinopse,
            style: TextStyle(fontSize: 14, height: 1.45),
          ),
        ],
      ),
    );
  }
}
