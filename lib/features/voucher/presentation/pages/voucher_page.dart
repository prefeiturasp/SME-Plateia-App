import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_state.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_cubit.dart';
import 'package:sme_plateia/core/utils/colors.dart';
import 'package:sme_plateia/core/extensions/datetime_extension.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';

import '../widgets/card_header_logos.dart';
import '../widgets/card_title.dart';
import '../widgets/icon_button.dart';
import '../widgets/list_item.dart';

@RoutePage()
class VoucherPage extends StatefulWidget {
  final int inscricaoId;
  final DateTime inscricaoData;
  final String eventoNome;
  final int ingressosPorMembro;
  final String local;
  final String endereco;
  final DateTime dataHora;
  final String userRF;
  final String userNome;

  const VoucherPage(
      {Key? key,
      required this.inscricaoId,
      required this.inscricaoData,
      required this.eventoNome,
      required this.ingressosPorMembro,
      required this.local,
      required this.endereco,
      required this.dataHora,
      required this.userRF,
      required this.userNome})
      : super(key: key);

  @override
  VoucherPageState createState() => VoucherPageState();
}

class VoucherPageState extends State<VoucherPage> {
  late VoucherCubit _voucherCubit;
  late VoucherFileCubit _voucherFileCubit;

  @override
  void initState() {
    super.initState();
    _voucherCubit = BlocProvider.of<VoucherCubit>(context);
    _voucherFileCubit = BlocProvider.of<VoucherFileCubit>(context);
    _voucherCubit.getVoucher(widget.inscricaoId);
  }

  void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _voucherFileCubit.closeVoucherFileAlert();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho('Voucher'),
      body: MultiBlocListener(
          listeners: [
            BlocListener<VoucherFileCubit, VoucherFileOpenState>(
              listener: (context, state) {
                if (state is VoucherFileOpenError) {
                  showAlert(context, state.title, state.message);
                }
              },
            ),
            BlocListener<VoucherCubit, VoucherState>(
              listener: (context, state) {},
            ),
          ],
          child: BlocBuilder<VoucherCubit, VoucherState>(
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
                        CardTitleWidget(title: widget.eventoNome),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          child: Text(
                            'Voucher gerado em: ${widget.inscricaoData.formatddMMyyy()}, às ${widget.inscricaoData.formatHHmm()}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.memory(
                                  _voucherCubit.getBase64QrcodeImage(voucher.qrcode),
                                  height: 150,
                                ),
                                SizedBox(height: 8.0),
                                Text('N ${widget.inscricaoId}',
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14))
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
                                    ListItemWidget(title: widget.userNome, icon: Icons.person_outlined),
                                    SizedBox(height: 16.0),
                                    ListItemWidget(title: 'RF $widget.userRF', icon: Icons.badge_outlined),
                                    SizedBox(height: 16.0),
                                    ListItemWidget(
                                        title: '${widget.dataHora.formatddMMyyy()} às ${widget.dataHora.formatHHmm()}',
                                        icon: Icons.calendar_today_outlined),
                                    SizedBox(height: 16.0),
                                    ListItemWidget(
                                        title: widget.local, subtitle: widget.endereco, icon: Icons.pin_drop_outlined),
                                    SizedBox(height: 16.0),
                                    ListItemWidget(
                                        title: 'Vale ${widget.ingressosPorMembro.toString()} ingresso(s)',
                                        icon: Icons.confirmation_num_outlined),
                                  ])),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        ButtonIconOutlinedWidget(
                          title: 'BAIXAR VOUCHER',
                          icon: Icons.download_outlined,
                          loading: state is VoucherFileLoading,
                          callback: () {
                            _voucherFileCubit.openVoucherPDF(voucher.voucher);
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Informações',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w700, color: TemaUtil.laranja01),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '''Os ingressos são pessoais e intransferíveis. Devem ser retirados na bilheteria com uma hora de antecedência e serão garantidos somente até 30 minutos antes do início do espetáculo. Após esse período, a critério dos produtores, o teatro poderá realizar a entrega dos ingressos ou disponibilizar o lugar reservado para venda. Apresentação do RG e Holerite é imprescindível.''',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
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
          )),
    );
  }
}
