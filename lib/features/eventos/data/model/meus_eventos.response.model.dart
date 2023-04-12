import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/eventos/data/model/evento_resumo.model.dart';

part 'meus_eventos.response.model.freezed.dart';
part 'meus_eventos.response.model.g.dart';

@freezed
abstract class MeusEventosResponseModel with _$MeusEventosResponseModel {
  factory MeusEventosResponseModel({
    @JsonKey(name: 'count') required int total,
    @JsonKey(name: 'next') String? proximo,
    @JsonKey(name: 'previous') String? anterior,
    @JsonKey(name: 'results') required List<EventoResumoModel> resultados,
  }) = _MeusEventosResponseModel;
  factory MeusEventosResponseModel.fromJson(Map<String, dynamic> json) => _$MeusEventosResponseModelFromJson(json);
}
