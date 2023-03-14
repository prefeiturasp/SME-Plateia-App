import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/themes/tema.util.dart';

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
            SizedBox(height: 40),
            TextButton(
              onPressed: () {},
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
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () => _esqueciSenha(),
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

  Container _buildInputRF() {
    return Container(
      constraints: BoxConstraints(maxWidth: 392),
      decoration: BoxDecoration(
        color: Color.fromARGB(15, 51, 51, 51),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextField(
          cursorColor: TemaUtil.amarelo01,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          focusNode: _codigoRFFocus,
          // onChanged: (value) => store.codigoEOL = value,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Usuário',
            labelStyle: TextStyle(
              color: TemaUtil.preto01,
            ),
            // errorText: store.autenticacaoErroStore.codigoEOL,
          ),
        ),
      ),
    );
  }

  Container _buildInputSenha() {
    return Container(
      constraints: BoxConstraints(maxWidth: 392),
      decoration: BoxDecoration(
        color: Color.fromARGB(15, 51, 51, 51),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextField(
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
              color: TemaUtil.pretoSemFoco,
              onPressed: () {
                //store.ocultarSenha = !store.ocultarSenha;
              },
            ),
            labelText: 'Senha',
            labelStyle: TextStyle(
              color: TemaUtil.preto01,
            ),
            // errorText: store.autenticacaoErroStore.senha,
            errorMaxLines: 3,
          ),
          onSubmitted: (value) => _fazerLogin(),
        ),
      ),
    );
  }

  _fazerLogin() {
    //TODO: implementar login
  }

  _esqueciSenha() {
    //TODO: navegar para esqueci a senha
  }
}
