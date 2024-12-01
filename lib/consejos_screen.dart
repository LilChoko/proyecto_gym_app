import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart'; // Asegúrate de tener esta pantalla implementada.

class ConsejosScreen extends StatefulWidget {
  @override
  _ConsejosScreenState createState() => _ConsejosScreenState();
}

class _ConsejosScreenState extends State<ConsejosScreen> {
  final List<Map<String, String>> consejos = [
    {
      'title': 'Consejo 1: Repeticiones y series',
      'content':
          'Recuerda que una repetición es una sola ejecución completa de un ejercicio mientras que una serie es un conjunto de repeticiones realizadas consecutivamente sin descanso.',
      'lottie': 'assets/tip1.json',
    },
    {
      'title': 'Consejo 2: Hidratación',
      'content':
          'Mantente hidratado durante tus entrenamientos. Beber agua ayuda a mejorar tu rendimiento y a prevenir calambres.',
      'lottie': 'assets/tip2.json',
    },
    {
      'title': 'Consejo 3: Técnica correcta',
      'content':
          'Prioriza la técnica sobre el peso para evitar lesiones y obtener mejores resultados en tus ejercicios.',
      'lottie': 'assets/tip3.json',
    },
    {
      'title': 'Consejo 4: Descanso',
      'content':
          'El descanso es crucial para la recuperación muscular. Asegúrate de dormir lo suficiente y dar tiempo a tus músculos para recuperarse.',
      'lottie': 'assets/tip1.json',
    },
    {
      'title': 'Consejo 5: Alimentación',
      'content':
          'Lleva una alimentación balanceada que incluya proteínas, carbohidratos y grasas saludables para optimizar tus entrenamientos.',
      'lottie': 'assets/tip2.json',
    },
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text(
          'Consejos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: ListView.builder(
          itemCount: consejos.length,
          itemBuilder: (context, index) {
            final consejo = consejos[index];
            final isExpanded = expandedIndex == index;

            return Card(
              elevation: 5,
              margin: EdgeInsets.only(bottom: size.height * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? null : index;
                  });
                },
                child: AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Text(
                      consejo['title']!,
                      style: TextStyle(
                        fontSize: isLandscape
                            ? size.width * 0.025
                            : size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0047AB),
                      ),
                    ),
                  ),
                  secondChild: Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          consejo['title']!,
                          style: TextStyle(
                            fontSize: isLandscape
                                ? size.width * 0.025
                                : size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0047AB),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Center(
                          child: Lottie.asset(
                            consejo['lottie']!,
                            height: isLandscape
                                ? size.height * 0.3
                                : size.height * 0.2,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          consejo['content']!,
                          style: TextStyle(
                            fontSize: isLandscape
                                ? size.width * 0.02
                                : size.width * 0.04,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
