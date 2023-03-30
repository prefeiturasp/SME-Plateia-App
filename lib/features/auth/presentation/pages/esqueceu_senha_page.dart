import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/core/utils/web_view.dart';

@RoutePage()
class EsqueceuSenhaPage extends StatefulWidget {
  const EsqueceuSenhaPage({super.key});

  @override
  State<EsqueceuSenhaPage> createState() => _EsqueceuSenhaPageState();
}

class _EsqueceuSenhaPageState extends State<EsqueceuSenhaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Esqueci minha senha"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24),
              color: const Color(0xffFBF2D0),
              child: Center(child: SvgPicture.asset('assets/images/esqueceu_senha.svg')),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    "Você será redirecionado(a) para o site do Plateia para recuperar sua senha.",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextButton(
                    onPressed: () async {
                      await _recuperarSenha();
                    },
                    child: Text('Recuperar minha senha'.toUpperCase()),
                  )
                ],
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

  _recuperarSenha() async {
    await launchURL(context, "http://identity.sme.prefeitura.sp.gov.br/Account/ForgotPassword");
  }
}
