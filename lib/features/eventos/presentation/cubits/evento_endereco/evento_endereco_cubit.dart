// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import 'package:sme_plateia/app/network/network_info.dart';

part 'evento_endereco_cubit.freezed.dart';
part 'evento_endereco_state.dart';

@Singleton()
class EventoEnderecoCubit extends Cubit<EventoEnderecoState> {
  final INetworkInfo networkInfo;

  EventoEnderecoCubit(
    this.networkInfo,
  ) : super(EventoEnderecoState.initial());

  findGeoPoint(String endereco) async {
    if (!await networkInfo.isConnected) {
      emit(EventoEnderecoState.offline());
      return;
    }

    emit(EventoEnderecoState.loading());

    var result = await encontrarGeopoint(endereco);

    result ??= await encontrarGeopoint(endereco.replaceAll(RegExp('\\(.*?\\)'), ''));

    if (result == null) {
      var regex = RegExp(r'((.*), (\d*))');
      String? ruaNumero = regex.firstMatch(endereco)?.group(1);

      result ??= await encontrarGeopoint(ruaNumero);
    }

    if (result == null) {
      var regex = RegExp(r'\(([^\)]+)\)');
      String? dentroParenteses = regex.firstMatch(endereco)?.group(1);

      result ??= await encontrarGeopoint(dentroParenteses);
    }

    if (result != null) {
      LatLng local = LatLng(result.lat, result.lon);

      emit(EventoEnderecoState.loaded(local));
    } else {
      emit(EventoEnderecoState.notFound());
    }
  }

  Future<Place?> encontrarGeopoint(String? endereco) async {
    if (endereco == null || endereco.isEmpty) {
      return null;
    }

    final List<Place> searchResult = await Nominatim.searchByName(
      query: endereco,
      limit: 1,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );

    if (searchResult.isNotEmpty) {
      return searchResult.first;
    }

    return null;
  }
}
