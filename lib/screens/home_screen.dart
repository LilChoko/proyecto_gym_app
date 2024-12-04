import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'peso_screen.dart';
import 'training_screen.dart';
import 'consejos_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
        centerTitle: true,
        title: Text(
          'Inicio',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sección de bienvenida con imagen de fondo
            Stack(
              children: [
                Container(
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/fondo_gym.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Row(
                    children: [
                      Container(
                        width:
                            isLandscape ? size.width * 0.1 : size.width * 0.15,
                        height:
                            isLandscape ? size.width * 0.1 : size.width * 0.15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: Color(0xFF0047AB),
                          size: isLandscape
                              ? size.width * 0.05
                              : size.width * 0.07,
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bienvenido',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isLandscape
                                  ? size.width * 0.035
                                  : size.width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Brazo de 35',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isLandscape
                                  ? size.width * 0.03
                                  : size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            // Botones en el centro de la pantalla (GridView adaptable)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: isLandscape ? 4 : 3,
                crossAxisSpacing: size.width * 0.03,
                mainAxisSpacing: size.height * 0.03,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildIconButton(
                    context: context,
                    icon: Icons.person,
                    label: 'Perfil',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.monitor_weight,
                    label: 'Control\nPeso',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PesoScreen()),
                      );
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.fitness_center,
                    label: 'Plan de\nEntrenamiento',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrainingScreen()),
                      );
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.lightbulb,
                    label: 'Consejos',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConsejosScreen()),
                      );
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.calendar_month_rounded,
                    label: 'Calendario',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      // Función para calendario
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.shopping_cart,
                    label: 'Pagar\nMensualidad',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      // Función para pago de mensualidad
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.exit_to_app,
                    label: 'Cerrar\nSesion',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      // Función para Cerrar Sesión
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Size size,
    required bool isLandscape,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(
                isLandscape ? size.width * 0.03 : size.width * 0.04),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isLandscape ? size.width * 0.05 : size.width * 0.07,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ) ??
              TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
