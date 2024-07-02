import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final bool automaticallyImplyLeading;
  final VoidCallback? onNotificationPressed;
  static bool centerTitle = true;

  const CustomAppBar({
    super.key,
    required this.pageTitle,
    this.automaticallyImplyLeading = false,
    this.onNotificationPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isHomePage = pageTitle == Dictionary.beranda;

    return AppBar(
      title: _checkPageName(pageTitle),
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      centerTitle: isHomePage ? false : true,
      actions: _buildActions(isHomePage),
    );
  }

  _checkPageName(String pageName) {
    String userName = "John Doe";

    if (pageName == Dictionary.beranda) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo,',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              userName,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(pageTitle);
    }
  }

  List<Widget> _buildActions(bool isHomePage) {
    List<Widget> actions = [];

    if (isHomePage) {
      actions.add(
        IconButton(
          icon: const Icon(
            Icons.notifications,
            // color: Theme.of(context).colorScheme.lightColor,
          ),
          onPressed: () {
            if (onNotificationPressed != null) onNotificationPressed!();
          },
        ),
      );
    }
    return actions;
  }
}
