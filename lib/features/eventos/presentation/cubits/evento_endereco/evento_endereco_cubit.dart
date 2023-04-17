import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

part 'evento_endereco_state.dart';
part 'evento_endereco_cubit.freezed.dart';

@Singleton()
class EventoEnderecoCubit extends Cubit<EventoEnderecoState> {
  EventoEnderecoCubit() : super(EventoEnderecoState.initial());

  findGeoPoint(String endereco) async {
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
