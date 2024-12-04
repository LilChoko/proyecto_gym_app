import 'package:flutter/material.dart';
import 'package:panthers_gym/screens/training_screen.dart';

class BroScreen extends StatefulWidget {
  @override
  _BroScreenState createState() => _BroScreenState();
}

class _BroScreenState extends State<BroScreen> {
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Pecho)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Aperturas con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Fondos en paralelas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
    ],
    'Martes (Espalda)': [
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto', 'series': 'Series: 3', 'reps': 'Reps: 6'},
      {
        'name': 'Remo con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
    ],
    'Miércoles (Piernas)': [
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Prensa de piernas', 'series': 'Series: 3', 'reps': 'Reps: 12'},
      {'name': 'Curl de piernas', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {
        'name': 'Elevaciones de talones',
        'series': 'Series: 4',
        'reps': 'Reps: 15'
      },
    ],
    'Jueves (Hombros)': [
      {'name': 'Press militar', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Elevaciones frontales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Elevaciones posteriores',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
    ],
    'Viernes (Brazos)': [
      {
        'name': 'Curl de bíceps con barra',
        'series': 'Series: 4',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Curl de bíceps con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
      {
        'name': 'Fondos para tríceps',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TrainingScreen()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Bro Split Plan',
          style: textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selecciona un día de entrenamiento',
              style: textTheme.headlineSmall?.copyWith(
                fontSize: isLandscape ? size.width * 0.025 : size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * (isLandscape ? 0.005 : 0.02)),
            Expanded(
              child: ListView.builder(
                itemCount: _workoutDays.keys.length,
                itemBuilder: (context, index) {
                  final day = _workoutDays.keys.elementAt(index);
                  return _buildDayCard(
                      day, size, isLandscape, theme, textTheme);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(String day, Size size, bool isLandscape, ThemeData theme,
      TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        _showExerciseModal(context, day, size, isLandscape, theme, textTheme);
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
                style: textTheme.bodyMedium?.copyWith(
                  fontSize:
                      isLandscape ? size.width * 0.025 : size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              Icon(Icons.arrow_forward,
                  color: theme.primaryColor,
                  size: size.width * (isLandscape ? 0.04 : 0.06)),
            ],
          ),
        ),
      ),
    );
  }

  void _showExerciseModal(BuildContext context, String day, Size size,
      bool isLandscape, ThemeData theme, TextTheme textTheme) {
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
              children: [
                Text(
                  'Ejercicios para $day',
                  style: textTheme.headlineSmall?.copyWith(
                    fontSize: size.width * (isLandscape ? 0.04 : 0.05),
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                        theme,
                        textTheme,
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

  Widget _buildExerciseCard(String name, String series, String reps, Size size,
      bool isLandscape, ThemeData theme, TextTheme textTheme) {
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
                Text(name,
                    style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: theme.hintColor)),
                if (series.isNotEmpty) Text(series, style: textTheme.bodySmall),
                if (reps.isNotEmpty) Text(reps, style: textTheme.bodySmall),
              ],
            ),
            Icon(Icons.fitness_center,
                color: theme.primaryColor,
                size: size.width * (isLandscape ? 0.04 : 0.07)),
          ],
        ),
      ),
    );
  }
}
