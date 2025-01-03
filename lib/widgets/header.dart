import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.blue, // Cor azul para o ícone
              ),
              SizedBox(width: 8.0),
              Text(
                "Taski",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3F3D56),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "John",
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3F3D56),
                ),
              ),
              SizedBox(width: 10),
              ClipOval(
                child: Image.asset(
                  'assets/images/profile.png', // Caminho correto da imagem
                  width: 40.0, // Largura do avatar
                  height: 40.0, // Altura do avatar
                  fit: BoxFit
                      .cover, // Ajuste de cobertura para não distorcer a imagem
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
