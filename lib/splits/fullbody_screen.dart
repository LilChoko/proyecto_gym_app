import 'package:flutter/material.dart';
import 'package:panthers_gym/screens/training_screen.dart';

class FullBodyScreen extends StatefulWidget {
  @override
  _FullBodyScreenState createState() => _FullBodyScreenState();
}

class _FullBodyScreenState extends State<FullBodyScreen> {
  // Datos de los ejercicios por día
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Cuerpo Completo)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Press militar', 'series': 'Series: 3', 'reps': 'Reps: 12'},
      {
        'name': 'Curl de bíceps con barra',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {'name': 'Crunches', 'series': 'Series: 4', 'reps': 'Reps: 20'},
    ],
    'Miércoles (Cuerpo Completo)': [
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 10'
      },
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto', 'series': 'Series: 3', 'reps': 'Reps: 6'},
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Curl de bíceps con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Fondos para tríceps',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Elevaciones de piernas',
        'series': 'Series: 4',
        'reps': 'Reps: 20'
      },
    ],
    'Viernes (Cuerpo Completo)': [
      {'name': 'Flexiones', 'series': 'Series: 4', 'reps': 'Reps: 15'},
      {
        'name': 'Remo con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 10'
      },
      {'name': 'Prensa de piernas', 'series': 'Series: 3', 'reps': 'Reps: 12'},
      {
        'name': 'Press militar con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {'name': 'Curl martillo', 'series': 'Series: 3', 'reps': 'Reps: 12'},
      {
        'name': 'Extension con barra Z',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {'name': 'Plancha', 'series': 'Series: 3', 'reps': 'Duración: 60 seg'},
    ],
    'Domingo (Full Body)': [
      {'name': 'Flexiones', 'series': 'Series: 4', 'reps': 'Reps: 12'},
      {
        'name': 'Remo con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 12'},
      {
        'name': 'Press militar con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Curl de bíceps con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Extensiones con agarre V',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Elevaciones de piernas',
        'series': 'Series: 4',
        'reps': 'Reps: 20'
      },
      {'name': 'Plancha', 'series': 'Series: 3', 'reps': 'Duración: 60 seg'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            // Regresar a TrainingScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TrainingScreen()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Full Body Plan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título principal
            Text(
              'Selecciona un día de entrenamiento',
              style: TextStyle(
                fontSize: isLandscape ? size.width * 0.025 : size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0047AB),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * (isLandscape ? 0.005 : 0.02)),

            // Tarjetas para seleccionar días
            Expanded(
              child: ListView.builder(
                itemCount: _workoutDays.keys.length,
                itemBuilder: (context, index) {
                  final day = _workoutDays.keys.elementAt(index);
                  return _buildDayCard(day, size, isLandscape);
                },
              ),
            ),
            // Botones de "Agregar al calendario" y "Eliminar del calendario"
            SizedBox(height: size.height * (isLandscape ? 0.005 : 0.02)),
            _buildActionButton(
              context: context,
              label: "Agregar al calendario",
              icon: Icons.calendar_today_outlined,
              color: Color(0xFF0047AB),
              size: size,
              isLandscape: isLandscape,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Entrenamiento agregado al calendario.'),
                  ),
                );
              },
            ),
            SizedBox(height: size.height * (isLandscape ? 0.005 : 0.01)),
            _buildActionButton(
              context: context,
              label: "Eliminar del calendario",
              icon: Icons.delete_outline,
              color: Colors.red,
              size: size,
              isLandscape: isLandscape,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Entrenamiento eliminado del calendario.'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Construcción de una tarjeta para los días de entrenamiento
  Widget _buildDayCard(String day, Size size, bool isLandscape) {
    return GestureDetector(
      onTap: () {
        _showExerciseModal(context, day, size, isLandscape);
      },
      child: Card(
        elevation: 5,
        margin:
            EdgeInsets.only(bottom: size.height * (isLandscape ? 0.01 : 0.02)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(size.width * (isLandscape ? 0.02 : 0.03)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize:
                      isLandscape ? size.width * 0.025 : size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB),
                ),
              ),
              Icon(Icons.arrow_forward,
                  color: Color(0xFF0047AB),
                  size: size.width * (isLandscape ? 0.04 : 0.06)),
            ],
          ),
        ),
      ),
    );
  }

  // Modal para mostrar ejercicios
  void _showExerciseModal(
      BuildContext context, String day, Size size, bool isLandscape) {
    final exercises = _workoutDays[day]!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: size.height * 0.02),
                Text(
                  'Ejercicios para $day',
                  style: TextStyle(
                    fontSize:
                        isLandscape ? size.width * 0.04 : size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0047AB),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return _buildExerciseCard(
                        exercise['name']!,
                        exercise['series']!,
                        exercise['reps']!,
                        size,
                        isLandscape,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Construcción de una tarjeta para los ejercicios
  Widget _buildExerciseCard(
    String name,
    String series,
    String reps,
    Size size,
    bool isLandscape,
  ) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
          vertical: size.height * (isLandscape ? 0.005 : 0.01)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(size.width * (isLandscape ? 0.02 : 0.03)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize:
                        isLandscape ? size.width * 0.02 : size.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (series.isNotEmpty)
                  Text(
                    series,
                    style: TextStyle(
                      fontSize:
                          isLandscape ? size.width * 0.02 : size.width * 0.04,
                      color: Colors.black54,
                    ),
                  ),
                if (reps.isNotEmpty)
                  Text(
                    reps,
                    style: TextStyle(
                      fontSize:
                          isLandscape ? size.width * 0.02 : size.width * 0.04,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
            Icon(Icons.fitness_center,
                color: Color(0xFF0047AB),
                size: size.width * (isLandscape ? 0.04 : 0.07)),
          ],
        ),
      ),
    );
  }

  // Botón reutilizable con diseño más pequeño en horizontal
  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required Size size,
    required bool isLandscape,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(
          vertical: size.height *
              (isLandscape ? 0.005 : 0.02), // Más pequeño en horizontal
          horizontal: size.width *
              (isLandscape ? 0.05 : 0.1), // Más compacto en horizontal
        ),
      ),
      icon: Icon(icon,
          color: Colors.white,
          size: size.width * (isLandscape ? 0.03 : 0.04)), // Ícono más pequeño
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize:
              size.width * (isLandscape ? 0.02 : 0.045), // Texto más pequeño
        ),
      ),
    );
  }
}
