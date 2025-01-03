import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoResultsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Campo de busca

          const SizedBox(
              height: 24), // Espaço entre o campo de busca e o restante
          SvgPicture.asset(
            'assets/images/task_icon.svg', // Caminho para o SVG
            height: 80.0, // Altura do SVG
            width: 82.0,
            fit: BoxFit.cover, // Ajusta o SVG para cobrir o espaço
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'No result found.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Urbanist',
                fontSize: 16,
                color: Color(0xFF8D9CB8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
