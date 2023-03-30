import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/app/router/app_router.dart';
import 'package:template/core/extensions/context_extensions.dart';
import 'package:template/core/utils/colors.dart';
import 'package:template/core/utils/constants.dart';
import 'package:template/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:template/injector.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/shared/flash/presentation/blocs/cubit/flash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<FlashCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FlashCubit, FlashState>(
            listener: (context, state) {
              state.when(
                disappeared: () => null,
                appeared: (message) => context.showSnackbar(
                  message: message,
                ),
              );
            },
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(ScreenUtilSize.width, ScreenUtilSize.height),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              scaffoldMessengerKey: rootScaffoldMessengerKey,
              theme: ThemeData(
                appBarTheme: const AppBarTheme(color: AppColor.primary),
                colorScheme: ColorScheme.fromSwatch(
                  accentColor: AppColor.primary,
                ),
                fontFamily: GoogleFonts.poppins().fontFamily,
                textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp, displayColor: AppColor.primary),
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: sl<AppRouter>().config(),
              builder: (context, widget) {
                return Theme(
                  data: ThemeData(
                    primaryColor: TemaUtil.amarelo01,
                    appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(color: TemaUtil.preto01),
                      foregroundColor: TemaUtil.preto01,
                      color: TemaUtil.amarelo01,
                    ),
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: TemaUtil.preto01,
                          displayColor: TemaUtil.preto01,
                          fontSizeFactor: 1.sp,
                        ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        backgroundColor: TemaUtil.amarelo01,
                        foregroundColor: TemaUtil.preto02,
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        minimumSize: Size(MediaQuery.of(context).size.width - 20, 40),
                      ),
                    ),
                    buttonTheme: ButtonThemeData(
                      buttonColor: Colors.yellow,
                      textTheme: ButtonTextTheme.primary,
                      colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
                    ),
                  ),
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp),
                    child: widget!,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
