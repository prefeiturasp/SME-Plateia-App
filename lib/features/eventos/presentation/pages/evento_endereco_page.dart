import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sme_plateia/features/eventos/presentation/cubits/evento_endereco/evento_endereco_cubit.dart';

import 'package:sme_plateia/gen/assets.gen.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';
import 'package:sme_plateia/shared/presentation/widgets/rodape.dart';

@RoutePage()
class EventoEnderecoPage extends HookWidget {
  final int eventoId;
  final String local;
  final String endereco;

  final _mapController = MapController();

  EventoEnderecoPage({
    Key? key,
    required this.eventoId,
    required this.endereco,
    required this.local,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventoEnderecoCubit = BlocProvider.of<EventoEnderecoCubit>(context);

    useEffect(() {
      eventoEnderecoCubit.findGeoPoint(endereco);

      return () {
        _mapController.dispose();
      };
    }, const []);

    return Scaffold(
      appBar: Cabecalho('Local do Evento'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            _buildLocalizacao(context),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: BlocBuilder<EventoEnderecoCubit, EventoEnderecoState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    offline: () {
                      return SizedBox.shrink();
                    },
                    loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                    loaded: (location) {
                      return FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          center: location,
                          zoom: 16,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: location,
                                width: 70,
                                height: 70,
                                anchorPos: AnchorPos.align(AnchorAlign.top),
                                builder: (context) => GestureDetector(
                                  onTap: () async {
                                    await MapsLauncher.launchQuery(endereco);
                                  },
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 70,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                    orElse: () => SizedBox.shrink(),
                  );
                },
              ),
            ),
            Rodape(),
          ],
        ),
      ),
    );
  }

  _buildLocalizacao(context) {
    return GestureDetector(
      onTap: () async {
        await MapsLauncher.launchQuery(endereco);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Assets.icons.local.svg(width: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  endereco,
                  maxLines: 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
