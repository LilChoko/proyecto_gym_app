import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panthers_gym/providers/auth_provider.dart' as custom_auth;
import 'package:panthers_gym/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'profile_screen.dart';
import 'peso_screen.dart';
import 'training_screen.dart';
import 'consejos_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    final authProvider = Provider.of<custom_auth.AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0047AB),
        centerTitle: true,
        title: const Text(
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
                      _buildWelcomeIcon(size, isLandscape),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bienvenido',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            authProvider.userName ?? 'Invitado',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
                physics: const NeverScrollableScrollPhysics(),
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
                      // Lógica para calendario
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.shopping_cart,
                    label: 'Pagar\nMensualidad',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () {
                      // Lógica para pago de mensualidad
                    },
                  ),
                  _buildIconButton(
                    context: context,
                    icon: Icons.exit_to_app,
                    label: 'Cerrar\nSesión',
                    size: size,
                    isLandscape: isLandscape,
                    onPressed: () async {
                      final authProvider =
                          Provider.of<custom_auth.AuthProvider>(context,
                              listen: false);

                      await authProvider.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
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

  // Widget para el ícono de bienvenida
  Widget _buildWelcomeIcon(Size size, bool isLandscape) {
    return Container(
      width: isLandscape ? size.width * 0.1 : size.width * 0.15,
      height: isLandscape ? size.width * 0.1 : size.width * 0.15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.8),
      ),
      child: Icon(
        Icons.fitness_center,
        color: const Color(0xFF0047AB),
        size: isLandscape ? size.width * 0.05 : size.width * 0.07,
      ),
    );
  }

  // Widget para un botón en el grid
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
            shape: const CircleBorder(),
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
              ),
        ),
      ],
    );
  }
}
