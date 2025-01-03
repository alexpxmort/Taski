import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String? item;

  final String confirmText;
  final Color confirmButtonColor;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    this.cancelText = 'Cancelar',
    this.confirmText = 'Confirmar',
    this.confirmButtonColor = const Color(0xFFFF5E5E),
    this.item, // Fire Red
  }) : super(key: key);

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    String? item,
    String cancelText = 'Cancelar',
    String confirmText = 'Confirmar',
    Color confirmButtonColor = const Color(0xFFFF5E5E), // Fire Red
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: title,
          content: content,
          cancelText: cancelText,
          item: item,
          confirmText: confirmText,
          confirmButtonColor: confirmButtonColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300, // Define uma largura máxima para o conteúdo
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (item != null && item!.isNotEmpty)
              Text(
                '"$item!"',
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Retorna false
          },
          child: Text(
            cancelText,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Retorna true
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmButtonColor,
          ),
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
