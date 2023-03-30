import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:template/features/auth/presentation/cubits/auth/auth_cubit.dart';

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
      appBar: AppBar(
        title: const Text('Eventos'),
        leading: TextButton(
          onPressed: () {
            context.read<AuthCubit>().logout();
          },
          child: Text('Sair'),
        ),
      ),
      body: Center(child: Text(context.read<AuthCubit>().state.toString())),
    );
  }
}
