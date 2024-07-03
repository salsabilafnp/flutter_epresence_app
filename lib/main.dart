import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/nav_component.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePresence',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const NavComponent(),
    );
  }
}
