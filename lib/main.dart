import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/app/modules/views/splash_screen.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Get.put(AuthController());

  initializeDateFormatting('id_ID', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'id_ID';

    return GetMaterialApp(
      title: 'ePresence',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
      getPages: Routes.pages,
    );
  }
}
