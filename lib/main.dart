import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/views/login_view.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'id_ID';

    return GetMaterialApp(
      title: 'ePresence',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: LoginView(),
      getPages: Routes.pages,
    );
  }
}
