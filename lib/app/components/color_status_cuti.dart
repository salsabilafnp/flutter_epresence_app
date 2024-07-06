import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';

class ColorStatusCuti extends StatelessWidget {
  final String statusAjuan;
  final bool isForDetail;

  const ColorStatusCuti({
    super.key,
    required this.statusAjuan,
    this.isForDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor;
    switch (statusAjuan) {
      case Dictionary.diajukan:
        textColor = Theme.of(context).colorScheme.secondary;
        break;
      case Dictionary.ditolak:
        textColor = Theme.of(context).colorScheme.error;
        break;
      case Dictionary.disetujui:
        textColor = Theme.of(context).colorScheme.onErrorContainer;
        break;
      default:
        textColor = Colors.grey;
    }

    return Text(
      statusAjuan,
      style: isForDetail
          ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              )
          : TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
    );
  }
}
