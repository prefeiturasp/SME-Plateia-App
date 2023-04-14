import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.codegen.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.localFailure({
    required String message,
  }) = LocalFailure;

  const factory Failure.serverFailure({
    required String message,
  }) = ServerFailure;

  const factory Failure.noConnectionFailure({
    @Default('Sem conexão com a internet') String message,
  }) = NoConnectionFailure;
}
