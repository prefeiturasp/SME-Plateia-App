import 'package:freezed_annotation/freezed_annotation.dart';

part 'arquivos.model.freezed.dart';
part 'arquivos.model.g.dart';

@freezed
class ArquivosModel with _$ArquivosModel {
  factory ArquivosModel({
    @JsonKey(name: 'name') required String nome,
    @JsonKey(name: 'path') required String path,
  }) = _ArquivosModel;
  factory ArquivosModel.fromJson(Map<String, dynamic> json) => _$ArquivosModelFromJson(json);
}
