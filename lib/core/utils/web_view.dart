import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

Future<void> launchURL(
  BuildContext context,
  String url,
) async {
  await launch(
    url,
    customTabsOption: CustomTabsOption(
      toolbarColor: Theme.of(context).primaryColor,
      enableDefaultShare: false,
      enableUrlBarHiding: false,
      showPageTitle: true,
      animation: CustomTabsSystemAnimation.fade(),
      extraCustomTabs: const <String>[
        'org.mozilla.firefox',
        'com.microsoft.emmx',
      ],
    ),
    safariVCOption: SafariViewControllerOption(
      preferredBarTintColor: Theme.of(context).primaryColor,
      preferredControlTintColor: Theme.of(context).appBarTheme.foregroundColor,
      barCollapsingEnabled: true,
      entersReaderIfAvailable: false,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.cancel,
    ),
  );
}
