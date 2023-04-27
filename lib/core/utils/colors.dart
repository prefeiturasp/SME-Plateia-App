import 'package:flutter/material.dart';

class AppColor {
  static const primary = Color(0xFF006BB3);
  static const blueLightest = Color(0xFFD7F4FE);
  static const blueLighter = Color(0xFFAAD9E9);
  static const blue = Color(0xFF62B8F6);
  static const blueDark = Color(0xFF3C99DD);
  static const blueDarker = Color(0xFF2C79C1);
  static const blueDarkest = Color(0xFF1B2541);
  static const white = Color(0xFFFFFFFF);

  static const pink = Color(0xFFFEE3D7);
  static const brownLight = Color(0xFFE9C8AA);
  static const orange = Color(0xFFF69762);
  static const orangeDark = Color(0xFFDD893C);
  static const orangeDarkest = Color(0xFFC25F14);

  static const grayLighter = Color(0xffE6E6E6);

  static const blueBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [blue, blueDarker],
    stops: [
      0,
      0.7,
    ],
  );
}

abstract class TemaUtil {
  //! CORES
  static const corDeFundo = Color(0xffE5E5E5);

  static const appBar = Color(0xFFFFD037);

  static const amarelo01 = Color(0xffFFD037);
  static const preto01 = Color(0xff42474A);
  static const preto02 = Color(0xff232526);

  static const laranja01 = Color(0xFFFF7755);
  static const laranja02 = Color(0xFFF2945B);
  static const laranja03 = Color(0xFFE99312);
  static const laranja04 = Color(0xFFF9A82F);
  static const vermelhoErro = Color(0xFFF92F57);
  static const branco = Colors.white;
  static const cinza01 = Colors.grey;
  static const cinza02 = Color(0xffE6E6E6);
  static const preto = Colors.black;
  static final preto2 = Colors.black.withOpacity(0.7);
  static const pretoSemFoco = Colors.black54;
  static const pretoSemFoco2 = Colors.black38;
  static const pretoSemFoco3 = Color(0xFF4D4D4D);
  static const azul = Colors.blue;
  static const azul02 = Color(0xFF2F304E);
  static const azulScroll = Color(0xff10A1C1);
  static const verde01 = Colors.green;
  static const verde02 = Color(0xff62C153);

  //* TEMA DE TEXTOS
  // static dynamic textoPrincipal(BuildContext context) {
  //   return GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
  // }
}
