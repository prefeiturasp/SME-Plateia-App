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
    final List<Place> searchResult = await Nominatim.searchByName(
      query: endereco,
      limit: 1,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );

    Place result = searchResult.first;
    LatLng local = LatLng(result.lat, result.lon);

    emit(EventoEnderecoState.loaded(local));
  }
}
