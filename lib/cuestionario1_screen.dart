import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panthers_gym/home_screen.dart';
import 'package:panthers_gym/home_screen.dart';

class CuestionarioScreen extends StatefulWidget {
  @override
  _CuestionarioScreenState createState() => _CuestionarioScreenState();
}

class _CuestionarioScreenState extends State<CuestionarioScreen> {
  int _selectedOption = -1; // Para seleccionar la opción en Cuestionario 1
  int _currentIndex = 0; // Índice de la pantalla actual en el PageView

  // Listas para cuestionario 2
  final List<int> alturas = List.generate(121, (index) => 100 + index);
  final List<int> pesos =
      List.generate(201, (index) => 40 + index); // 40kg a 240kg
  final List<int> edades = List.generate(86, (index) => 14 + index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB),
        centerTitle: true,
        title: Text(
          'Informacion Personal',
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
            padding: const EdgeInsets.only(
                bottom: 16.0), // Espaciado desde la parte inferior
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
    String? _selectedGender; // Variable para almacenar la selección de género

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título
            Text(
              'Datos Personales',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Campo de texto para nombre
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Campo numérico para altura
            TextField(
              keyboardType: TextInputType.number, // Teclado numérico
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Campo numérico para peso
            TextField(
              keyboardType: TextInputType.number, // Teclado numérico
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
              'assets/empecemos.json', // Ruta al archivo Lottie
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text(
                'Empecemos',
                style: TextStyle(color: Colors.white), // Texto en blanco
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

  // Función para ir a la siguiente página
  void _goToNextPage() {
    setState(() {
      _currentIndex = (_currentIndex + 1).clamp(0, 2);
    });
  }
}
