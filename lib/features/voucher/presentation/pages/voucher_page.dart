import 'dart:convert';
import 'package:sme_plateia/injector.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sme_plateia/gen/assets.gen.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_state.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_cubit.dart';

@RoutePage()
class VoucherPage extends StatelessWidget {
  final String voucherId;

  const VoucherPage({Key? key, required this.voucherId}) : super(key: key);

  String getSmallImageBase64() {
    String base64Image =
        'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=';
    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    final voucherCubit = VoucherCubit(sl());
    voucherCubit.getVoucher(voucherId);
    return BlocProvider<VoucherCubit>(
        create: (context) => VoucherCubit(sl()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Voucher'),
            leading: BackButton(
              onPressed: () {
                context.back();
              },
            ),
          ),
          body: BlocBuilder<VoucherCubit, VoucherState>(
            builder: (context, state) {
              if (state is VoucherLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is VoucherLoaded) {
                final voucher = state.voucher;
                return SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Assets.images.logo.image(),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Assets.images.logoSaopaulo.image(),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Clássicos do cinema',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Voucher gerado em: 07/03/2023, às 08:00',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.memory(
                                  base64.decode(getSmallImageBase64()),
                                  height: 100,
                                ),
                                Text('N 12345',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14))
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  width: double.infinity,
                                  color: Color(0xFFF3F3F3),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person_outlined,
                                            color: Color(0xFFC65D00)),
                                        SizedBox(width: 16.0),
                                        Text(
                                          'Maria Rodrigues Alves',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Text(
                                          'RF:',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(width: 16.0),
                                        Text(
                                          '2868211',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today_outlined,
                                            color: Color(0xFFC65D00)),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: Text(
                                            '07/03/2023 (Terça- feira)',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.alarm_outlined,
                                            color: Color(0xFFC65D00)),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: Text(
                                            '11:30',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Icon(Icons.pin_drop_outlined,
                                              color: Color(0xFFC65D00)),
                                        ),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          flex: 11,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Teatro J Safra',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                'Rua Josef Kryss 318, Barra Funda São Paulo',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Icon(Icons.confirmation_num_outlined,
                                            color: Color(0xFFC65D00)),
                                        SizedBox(width: 16.0),
                                        Text(
                                          'Vale 2 ingresso(s)',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        OutlinedButton(
                            onPressed: () {
                              // Função a ser executada quando o botão for pressionado
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: BorderSide(
                                color: Color(0xFFC65D00),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'BAIXAR VOUCHER',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(Icons.download_outlined,
                                    color: Colors.black),
                              ],
                            )),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Informações',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFC65D00)),
                                  ),
                                  SizedBox(height: 8.0),
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 270),
                                    child: Text(
                                      'Os ingressos são pessoais e intransferíveis. Devem ser retirados na bilheteria com uma hora de antecedência e serão garantidos somente até 30 minutos antes do início do espetáculo. Após esse período, a critério dos produtores, o teatro poderá realizar a entrega dos ingressos ou disponibilizar o lugar reservado para venda. Apresentação do RG e Holerite é imprescindível.',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is VoucherError) {
                return Center(
                  child: Text('text'),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
