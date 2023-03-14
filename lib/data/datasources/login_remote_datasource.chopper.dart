// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_remote_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$LoginRemoteDataSource extends LoginRemoteDataSource {
  _$LoginRemoteDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = LoginRemoteDataSource;

  @override
  Future<void> login(
    dynamic login,
    dynamic senha,
  ) {
    final Uri $url = Uri.parse('v1/login');
    final $body = <String, dynamic>{
      'login': login,
      'senha': senha,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send($request);
  }
}
