import 'package:flutter_triple/flutter_triple.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/errors/failures.dart';
import 'package:sme_plateia/core/utils/state_manager/custom_either_adapter.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';
import 'package:sme_plateia/domain/usecases/autenticacao/autenticar_usecase.dart';

@injectable
class AutenticarStore extends StreamStore<Failure, Autenticacao> {
  final AutenticarUseCase useCase;

  AutenticarStore(this.useCase) : super(Autenticacao(token: ""));

  Future<void> autenticar(String login, String senha) async {
    setLoading(true);

    // if (login.isEmpty) {
    //   setError(Failure());
    // }

    executeEither(
      () => CustomEitherAdapter.adapter(
        useCase(Params(login: login, senha: senha)),
      ),
    );

    setLoading(false);
  }
}
