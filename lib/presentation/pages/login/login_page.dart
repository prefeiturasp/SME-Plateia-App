import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:sme_plateia/core/di/dependency_injection_conf.dart';
import 'package:sme_plateia/core/errors/failures.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

import '../../../app/themes/tema.util.dart';
import 'stores/login_store.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.onLoginResult,
  });

  final void Function(bool isLoggedIn)? onLoginResult;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _codigoRFFocus = FocusNode();
  final FocusNode _senhaFocus = FocusNode();

  final autenticacaoStore = sl<AutenticarStore>();

  final textControllerLogin = TextEditingController();
  final textControllerSenha = TextEditingController();

  @override
  void initState() {
    autenticacaoStore.observer(
      onError: (error) => debugPrint(error.toString()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TemaUtil.corDeFundo,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 44),
            Center(child: Image.asset('assets/images/logo.png')),
            SizedBox(height: 66),
            Expanded(
              child: _buildFormulario(),
            ),
          ],
        ),
      ),
    );
  }

  _buildFormulario() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildInputRF(),
            SizedBox(height: 24),
            _buildInputSenha(),
            SizedBox(height: 8),
            TripleBuilder<AutenticarStore, Failure, Autenticacao>(
              store: autenticacaoStore,
              builder: (context, triple) {
                return Visibility(
                  visible: triple.error != null,
                  child: Text(
                    "Usuario ou senha incorretos",
                    style: TextStyle(
                      color: TemaUtil.vermelhoErro,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 8 * 3),
            TripleBuilder<AutenticarStore, Failure, Autenticacao>(
              store: autenticacaoStore,
              builder: (context, triple) {
                if (triple.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return TextButton(
                  onPressed: () async {
                    await _fazerLogin();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: TemaUtil.amarelo01,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width - 20, 40)),
                  child: Text(
                    'ENTRAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(34, 36, 38, 1),
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () async => await _esqueciSenha(),
              child: Text(
                "Esqueci minha senha",
                style: TextStyle(
                  color: TemaUtil.preto01,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/logo_saopaulo.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputRF() {
    return TripleBuilder<AutenticarStore, Failure, Autenticacao>(
      store: autenticacaoStore,
      builder: (context, triple) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(15, 51, 51, 51),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: triple.error != null ? TemaUtil.vermelhoErro : Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: TextField(
              controller: textControllerLogin,
              cursorColor: TemaUtil.amarelo01,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              focusNode: _codigoRFFocus,
              // onChanged: (value) => store.codigoEOL = value,
              decoration: InputDecoration(
                border: InputBorder.none,

                labelText: 'Usuário',
                labelStyle: TextStyle(
                  color: triple.error != null ? TemaUtil.vermelhoErro : TemaUtil.preto01,
                ),
                // errorText: store.autenticacaoErroStore.codigoEOL,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputSenha() {
    return TripleBuilder<AutenticarStore, Failure, Autenticacao>(
      store: autenticacaoStore,
      builder: (context, triple) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(15, 51, 51, 51),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: triple.error != null ? TemaUtil.vermelhoErro : Colors.transparent),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: TextField(
              controller: textControllerSenha,
              cursorColor: TemaUtil.amarelo01,
              // obscureText: store.ocultarSenha,
              keyboardType: TextInputType.number,
              // onChanged: (value) => store.senha = value,
              focusNode: _senhaFocus,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off),
                  color: triple.error != null ? TemaUtil.vermelhoErro : TemaUtil.pretoSemFoco,
                  onPressed: () {
                    //store.ocultarSenha = !store.ocultarSenha;
                  },
                ),
                labelText: 'Senha',
                labelStyle: TextStyle(
                  color: triple.error != null ? TemaUtil.vermelhoErro : TemaUtil.preto01,
                ),
                // errorText: store.autenticacaoErroStore.senha,
                errorMaxLines: 3,
              ),
              onSubmitted: (value) async => await _fazerLogin(),
            ),
          ),
        );
      },
    );
  }

  _fazerLogin() async {
    final userLogin = textControllerLogin.text;
    final userSenha = textControllerSenha.text;

    await autenticacaoStore.autenticar(userLogin, userSenha);
  }

  _esqueciSenha() async {
    //TODO: navegar para esqueci a senha
    throw Exception();
  }
}
