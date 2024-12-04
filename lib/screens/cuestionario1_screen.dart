import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class CuestionarioScreen extends StatefulWidget {
  @override
  _CuestionarioScreenState createState() => _CuestionarioScreenState();
}

class _CuestionarioScreenState extends State<CuestionarioScreen> {
  int _selectedOption = -1; // Para seleccionar la opción en Cuestionario 1
  int _currentIndex = 0; // Índice de la pantalla actual en el PageView

  // Variables para almacenar datos personales
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
        centerTitle: true,
        title: Text(
          'Información Personal',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Contenido principal: Página deslizante
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                // Cuestionario 1
                _buildCuestionario1(),
                // Cuestionario 2
                _buildCuestionario2(),
                // Pantalla final con animación Lottie
                _buildFinalScreen(),
              ],
            ),
          ),
          // Indicador de progreso en la posición deseada
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Color(0xFF0047AB)
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Cuestionario 1
  Widget _buildCuestionario1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '¿Tienes experiencia en el gimnasio?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            _buildOptionCard(
                0, 'Principiante', 'Es mi primera vez haciendo pesas'),
            SizedBox(height: 25),
            _buildOptionCard(
                1, 'Intermedio', 'Tengo al menos 1 año haciendo pesas'),
            SizedBox(height: 25),
            _buildOptionCard(
                2, 'Avanzado', 'Tengo al menos 5 años haciendo pesas'),
          ],
        ),
      ),
    );
  }

  // Construir tarjeta de opción con selección
  Widget _buildOptionCard(int index, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = index;
          _goToNextPage();
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: _selectedOption == index
            ? Color(0xFF0047AB).withOpacity(0.2)
            : Colors.white,
        child: ListTile(
          leading: _selectedOption == index
              ? Icon(Icons.check_circle, color: Color(0xFF0047AB))
              : Icon(Icons.circle_outlined, color: Colors.grey),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }

  // Cuestionario 2
  Widget _buildCuestionario2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Datos Personales',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Campo de texto para nombre
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Campo numérico para altura
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Campo numérico para peso
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Dropdown personalizado para género
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Género',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  value: _selectedGender,
                  hint: Text('Selecciona tu género'),
                  items: ['Hombre', 'Mujer', 'Prefiero no decirlo']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Pantalla final con animación Lottie
  Widget _buildFinalScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/empecemos.json',
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Lo que enfrentamos puede parecer insuperable.\nPero aprendí algo de todas esas series y repeticiones cuando no pensé que podría levantar otra onza de peso.\nLo que aprendí es que siempre somos más fuertes de lo que pensamos.\n\n~Arnold Schwarzenegger',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: _completeQuestionnaire,
              child: Text(
                'Finalizar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0047AB),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para finalizar el cuestionario
  Future<void> _completeQuestionnaire() async {
    final prefs = await SharedPreferences.getInstance();

    // Guardar los datos en SharedPreferences
    await prefs.setBool('completedQuestionnaire', true);
    await prefs.setString('name', _nameController.text);
    await prefs.setString('height', _heightController.text);
    await prefs.setString('weight', _weightController.text);
    await prefs.setString('gender', _selectedGender ?? '');

    // Redirigir a HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  // Función para ir a la siguiente página
  void _goToNextPage() {
    setState(() {
      _currentIndex = (_currentIndex + 1).clamp(0, 2);
    });
  }
}
