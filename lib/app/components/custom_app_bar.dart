import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final String role;
  final VoidCallback? onNotificationPressed;
  static bool centerTitle = true;

  const CustomAppBar({
    super.key,
    required this.pageTitle,
    this.role = Dictionary.staff,
    this.onNotificationPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isHomePage = pageTitle == Dictionary.beranda;

    return AppBar(
      title: _checkPageName(context, pageTitle),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      centerTitle: isHomePage ? false : true,
      actions: _buildActions(isHomePage),
    );
  }

  _checkPageName(BuildContext context, String pageName) {
    String userName = "Pengguna";

    AuthController authController = Get.find();
    final currentUser = authController.user.value;

    if (currentUser != null) {
      userName = currentUser.name ?? "Pengguna";
    }

    if (pageName == Dictionary.beranda) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo,',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              userName,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    } else {
      return Text(
        pageTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  List<Widget> _buildActions(bool isHomePage) {
    List<Widget> actions = [];

    if (isHomePage) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            if (role == Dictionary.admin) {
              Get.toNamed(RouteNames.notifAdmin);
            } else if (role == Dictionary.staff) {
              Get.toNamed(RouteNames.notifStaff);
            }
          },
        ),
      );
    }
    return actions;
  }
}
