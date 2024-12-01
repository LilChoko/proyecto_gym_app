import 'package:flutter/material.dart';
import 'package:panthers_gym/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener las dimensiones de la pantalla para diseño responsivo
    final size = MediaQuery.of(context).size;
    final isLandscape =
        size.width > size.height; // Detectar orientación horizontal

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
        centerTitle: true,
        leading: BackButton(
          color: Colors.white, // Botón para regresar
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        // Habilitar desplazamiento
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen de fondo y avatar
            Stack(
              clipBehavior:
                  Clip.none, // Permitir que el avatar se salga del contenedor
              children: [
                // Imagen de fondo
                Container(
                  height: isLandscape
                      ? size.height * 0.15
                      : size.height * 0.3, // Más pequeña en horizontal
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/gym_fondo2.jpg'), // Reemplaza con tu imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Avatar encima de la imagen
                Positioned(
                  bottom: isLandscape
                      ? -size.width * 0.03
                      : -size.width * 0.1, // Más arriba en horizontal
                  left:
                      size.width * 0.05, // Ajustar el avatar hacia la izquierda
                  child: CircleAvatar(
                    radius: isLandscape
                        ? size.width * 0.08
                        : size.width * 0.15, // Aún más pequeño en horizontal
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      'assets/avatar.jpg', // Imagen del avatar
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: isLandscape
                    ? size.height * 0.05
                    : size.height * 0.15), // Ajustar el espaciado

            // Contenido principal
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  Text(
                    'Tu Información',
                    style: TextStyle(
                      fontSize: isLandscape
                          ? size.width * 0.035
                          : size.width * 0.06, // Más pequeño en horizontal
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0047AB),
                    ),
                  ),
                  SizedBox(
                      height:
                          size.height * 0.02), // Espaciado entre título y datos

                  // Información del usuario
                  _buildUserInfoRow(
                    icon: Icons.person,
                    label: 'Nombre',
                    value: 'Brazo de 35',
                    size: size,
                    isLandscape: isLandscape,
                  ),
                  SizedBox(height: size.height * 0.015),
                  _buildUserInfoRow(
                    icon: Icons.height,
                    label: 'Altura',
                    value: '175 cm',
                    size: size,
                    isLandscape: isLandscape,
                  ),
                  SizedBox(height: size.height * 0.015),
                  _buildUserInfoRow(
                    icon: Icons.monitor_weight,
                    label: 'Peso',
                    value: '70 kg',
                    size: size,
                    isLandscape: isLandscape,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar la información del usuario
  Widget _buildUserInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Size size,
    required bool isLandscape,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Color(0xFF0047AB),
          size: isLandscape
              ? size.width * 0.04
              : size.width * 0.07, // Más pequeño en horizontal
        ),
        SizedBox(width: size.width * 0.04),
        Expanded(
          child: Text(
            '$label: $value',
            style: TextStyle(
              fontSize: isLandscape
                  ? size.width * 0.03
                  : size.width * 0.045, // Más pequeño en horizontal
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
