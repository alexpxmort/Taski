import 'package:flutter/material.dart';

class CreateTaskButton extends StatelessWidget {
  final VoidCallback onPress; // Callback para ação ao pressionar o botão

  const CreateTaskButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: Color(0xFFEAF5FF), // Fundo azul-claro
          borderRadius: BorderRadius.circular(16.0), // Bordas arredondadas
        ),
        child: Row(
          mainAxisSize:
              MainAxisSize.min, // Tamanho mínimo para conter o conteúdo
          children: [
            Icon(
              Icons.add,
              color: Colors.blue, // Ícone azul
              size: 20.0,
            ),
            SizedBox(width: 4.0), // Espaçamento entre ícone e texto
            Text(
              "Create task",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
