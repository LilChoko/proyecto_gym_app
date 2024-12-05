import 'package:flutter/material.dart';
import 'package:panthers_gym/screens/training_screen.dart';
import 'package:panthers_gym/providers/ppl_provider.dart';
import 'package:provider/provider.dart';

class PPLScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    final provider = Provider.of<PPLProvider>(context);

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
          'Push, Pull, Legs Plan',
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
                itemCount: provider.workoutDays.keys.length,
                itemBuilder: (context, index) {
                  final day = provider.workoutDays.keys.elementAt(index);
                  return _buildDayCard(
                    context,
                    day,
                    size,
                    isLandscape,
                    theme,
                    textTheme,
                    provider,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(
    BuildContext context,
    String day,
    Size size,
    bool isLandscape,
    ThemeData theme,
    TextTheme textTheme,
    PPLProvider provider,
  ) {
    return GestureDetector(
      onTap: () {
        _showExerciseModal(
            context, day, size, isLandscape, theme, textTheme, provider);
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

  void _showExerciseModal(
    BuildContext context,
    String day,
    Size size,
    bool isLandscape,
    ThemeData theme,
    TextTheme textTheme,
    PPLProvider provider,
  ) {
    final exercises = provider.workoutDays[day]!;

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

  Widget _buildExerciseCard(
    String name,
    String series,
    String reps,
    Size size,
    bool isLandscape,
    ThemeData theme,
    TextTheme textTheme,
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
                Text(name,
                    style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: theme.hintColor)),
                Text(series, style: textTheme.bodySmall),
                Text(reps, style: textTheme.bodySmall),
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
