import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/shared/domain/entities/value_objects.dart';

part 'evento_cidade.model.freezed.dart';
part 'evento_cidade.model.g.dart';

@freezed
class EventoCidadeModel with _$EventoCidadeModel {
  factory EventoCidadeModel({
    required String id,
    @JsonKey(name: "name") required String nome,
  }) = _EventoCidadeModel;
  factory EventoCidadeModel.fromJson(Map<String, dynamic> json) => _$EventoCidadeModelFromJson(json);
}
