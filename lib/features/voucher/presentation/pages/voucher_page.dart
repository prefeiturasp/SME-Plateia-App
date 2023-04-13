import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_state.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_cubit.dart';
import 'package:sme_plateia/gen/assets.gen.dart';
import 'package:sme_plateia/core/utils/colors.dart';

@RoutePage()
class VoucherPage extends StatelessWidget {
  final String voucherId;

  const VoucherPage({Key? key, required this.voucherId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final voucherCubit = BlocProvider.of<VoucherCubit>(context);
    voucherCubit.getVoucher(voucherId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voucher',
          style: TextStyle(fontSize: 24),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<VoucherCubit, VoucherState>(
        builder: (context, state) {
          if (state is VoucherLoading) {
            return Center(
              child: CircularProgressIndicator(color: TemaUtil.laranja01),
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
                    CardHeaderLogoWidget(),
                    CardTitleWidget(title: voucher.evento),
                    SizedBox(height: 16.0),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Text(
                    //     'Voucher gerado em: 07/03/2023, às 08:00',
                    //     style: TextStyle(
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.memory(
                              voucherCubit.getBase64QrcodeImage(voucher.qrcode),
                              height: 150,
                            ),
                            SizedBox(height: 8.0),
                            Text('N ${voucher.inscricao_id}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14))
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
                                ListItemWidget(
                                    title: voucher.nome,
                                    icon: Icons.person_outlined),
                                SizedBox(height: 16.0),
                                ListItemWidget(
                                    title: 'RF ${voucher.rf}',
                                    icon: Icons.badge_outlined),
                                SizedBox(height: 16.0),
                                ListItemWidget(
                                    title:
                                        '${voucher.data} às ${voucher.horario}',
                                    icon: Icons.calendar_today_outlined),
                                SizedBox(height: 16.0),
                                ListItemWidget(
                                    title: voucher.local,
                                    subtitle: voucher.endereco,
                                    icon: Icons.pin_drop_outlined),
                                SizedBox(height: 16.0),
                                ListItemWidget(
                                    title: voucher.ingressos_por_membro,
                                    icon: Icons.confirmation_num_outlined),
                              ])),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    ButtonIconOutlinedWidget(
                      title: 'BAIXAR VOUCHER',
                      icon: Icons.download_outlined,
                      callback: () {
                        voucherCubit.openVoucherFile(voucherId);
                      },
                    ),
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
                                    color: TemaUtil.laranja01),
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                constraints: BoxConstraints(maxWidth: 270),
                                child: Text(
                                  '''Os ingressos são pessoais e intransferíveis. Devem ser retirados na bilheteria com uma hora de antecedência e serão garantidos somente até 30 minutos antes do início do espetáculo. Após esse período, a critério dos produtores, o teatro poderá realizar a entrega dos ingressos ou disponibilizar o lugar reservado para venda. Apresentação do RG e Holerite é imprescindível.''',
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
              child: Text(
                'Ops! Houve um problema ao carregar voucher.',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const ListItemWidget(
      {required this.title, required this.icon, this.subtitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(icon, color: TemaUtil.laranja01),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) SizedBox(height: 8.0),
                if (subtitle != null)
                  Text(subtitle!,
                      style: TextStyle(
                        fontSize: 16,
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonIconOutlinedWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? callback;

  const ButtonIconOutlinedWidget(
      {required this.title, required this.icon, Key? key, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: callback,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: BorderSide(
                  color: TemaUtil.laranja01,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(icon, color: Colors.black),
                ],
              )),
        ],
      ),
    );
  }
}

class CardHeaderLogoWidget extends StatelessWidget {
  const CardHeaderLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class CardTitleWidget extends StatelessWidget {
  final String title;
  const CardTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
