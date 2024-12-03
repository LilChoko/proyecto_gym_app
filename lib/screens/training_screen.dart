import 'package:flutter/material.dart';
import 'package:panthers_gym/screens/home_screen.dart';
import 'package:panthers_gym/splits/bro_screen.dart';
import 'package:panthers_gym/splits/fullbody_screen.dart';
import 'package:panthers_gym/splits/heavy_screen.dart';
import 'package:panthers_gym/splits/arnold_screen.dart';
import 'package:panthers_gym/splits/ppl_screen.dart';
import 'package:panthers_gym/splits/upperlower_screen.dart';

class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla para diseño responsivo
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    // Lista de datos para las tarjetas
    final List<Map<String, String>> trainingPrograms = [
      {'title': 'Heavy Duty', 'image': 'assets/heavy.jpg'},
      {'title': 'Arnold Split', 'image': 'assets/arnold1.jpg'},
      {'title': 'Push, Pull, Legs (PPL)', 'image': 'assets/tr3.jpg'},
      {'title': 'Upper/Lower Split', 'image': 'assets/phul.jpg'},
      {'title': 'Bro Split', 'image': 'assets/brosplit.jpg'},
      {'title': 'Full Body', 'image': 'assets/tr2.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
        leading: BackButton(
          color: Colors.white, // Botón para regresar
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Training Plan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: ListView.builder(
          itemCount: trainingPrograms.length,
          itemBuilder: (context, index) {
            final program = trainingPrograms[index];
            return _buildTrainingCard(
              context: context, // Contexto para la navegación
              title: program['title']!,
              imagePath: program['image']!,
              size: size,
              isLandscape: isLandscape,
              index: index, // Pasar el índice de la tarjeta
            );
          },
        ),
      ),
    );
  }

  // Widget para construir una tarjeta de entrenamiento
  Widget _buildTrainingCard({
    required BuildContext context, // Agregar contexto para navegación
    required String title,
    required String imagePath,
    required Size size,
    required bool isLandscape,
    required int index, // Índice para identificar la tarjeta
  }) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          // Imagen de fondo con opacidad
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: isLandscape ? size.height * 0.3 : size.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Capa semitransparente encima de la imagen
                Container(
                  height: isLandscape ? size.height * 0.3 : size.height * 0.2,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4), // Ajusta la opacidad
                ),
              ],
            ),
          ),
          // Contenido encima de la imagen
          Positioned(
            top: size.height * 0.02,
            left: size.width * 0.05,
            child: Text(
              'Entrenamiento',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isLandscape ? size.width * 0.03 : size.width * 0.04,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.06,
            left: size.width * 0.05,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isLandscape ? size.width * 0.045 : size.width * 0.06,
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.02,
            right: size.width * 0.05,
            child: ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla correspondiente según el índice
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HeavyScreen()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArnoldScreen()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PPLScreen()),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpperLowerScreen()),
                  );
                } else if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BroScreen()),
                  );
                } else if (index == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FullBodyScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pantalla no disponible aún'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0047AB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.01,
                ),
              ),
              child: Text(
                'Detalles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isLandscape ? size.width * 0.03 : size.width * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
