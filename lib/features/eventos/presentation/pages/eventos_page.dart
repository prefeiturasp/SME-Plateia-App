import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/shared/presentation/widgets/text_button.dart';
import 'package:sme_plateia/shared/presentation/widgets/cabecalho.dart';

@RoutePage()
class EventosPage extends StatefulWidget {
  const EventosPage({super.key});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(),
      body: Center(
        // child: Text(context.read<AuthCubit>().state.toString()),
        child: ButtonText(
          onPressed: () async {
            context.pushRoute(VoucherRoute(voucherId: '41584'));
          },
          text: 'Ver voucher'.toUpperCase(),
        ),
      ),
    );
  }
}
