import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:panthers_gym/providers/training_provider.dart';
import 'home_screen.dart';

class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingProvider>(context);
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Colors.white,
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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: ListView.builder(
          itemCount: trainingProvider.trainingPrograms.length,
          itemBuilder: (context, index) {
            final program = trainingProvider.trainingPrograms[index];
            return _buildTrainingCard(
              context: context,
              title: program['title'],
              imagePath: program['image'],
              size: size,
              isLandscape: isLandscape,
              index: index,
              trainingProvider: trainingProvider,
            );
          },
        ),
      ),
    );
  }

  Widget _buildTrainingCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required Size size,
    required bool isLandscape,
    required int index,
    required TrainingProvider trainingProvider,
  }) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
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
                Container(
                  height: isLandscape ? size.height * 0.3 : size.height * 0.2,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.02,
            left: size.width * 0.05,
            child: Text(
              'Entrenamiento',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        isLandscape ? size.width * 0.03 : size.width * 0.04,
                  ),
            ),
          ),
          Positioned(
            top: size.height * 0.06,
            left: size.width * 0.05,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        isLandscape ? size.width * 0.045 : size.width * 0.06,
                  ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.02,
            right: size.width * 0.05,
            child: ElevatedButton(
              onPressed: () {
                trainingProvider.navigateToProgram(context, index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize:
                          isLandscape ? size.width * 0.03 : size.width * 0.04,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
