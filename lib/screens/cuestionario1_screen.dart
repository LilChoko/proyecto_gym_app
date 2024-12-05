import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panthers_gym/providers/cuestionario_provider.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class CuestionarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cuestionarioProvider = Provider.of<CuestionarioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0047AB),
        centerTitle: true,
        title: const Text(
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
                cuestionarioProvider.nextPage();
              },
              children: [
                _buildCuestionario1(context),
                _buildCuestionario2(context),
                _buildFinalScreen(context),
              ],
            ),
          ),
          // Indicador de progreso
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: cuestionarioProvider.currentIndex == index
                        ? const Color(0xFF0047AB)
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

  Widget _buildCuestionario1(BuildContext context) {
    final cuestionarioProvider = Provider.of<CuestionarioProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '¿Tienes experiencia en el gimnasio?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            _buildOptionCard(
                context, 0, 'Principiante', 'Es mi primera vez haciendo pesas'),
            const SizedBox(height: 25),
            _buildOptionCard(context, 1, 'Intermedio',
                'Tengo al menos 1 año haciendo pesas'),
            const SizedBox(height: 25),
            _buildOptionCard(
                context, 2, 'Avanzado', 'Tengo al menos 5 años haciendo pesas'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context, int index, String title, String subtitle) {
    final cuestionarioProvider = Provider.of<CuestionarioProvider>(context);

    return GestureDetector(
      onTap: () {
        cuestionarioProvider.selectOption(index);
        cuestionarioProvider.nextPage();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: cuestionarioProvider.selectedOption == index
            ? const Color(0xFF0047AB).withOpacity(0.2)
            : Colors.white,
        child: ListTile(
          leading: Icon(
            cuestionarioProvider.selectedOption == index
                ? Icons.check_circle
                : Icons.circle_outlined,
            color: cuestionarioProvider.selectedOption == index
                ? const Color(0xFF0047AB)
                : Colors.grey,
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }

  Widget _buildCuestionario2(BuildContext context) {
    final cuestionarioProvider = Provider.of<CuestionarioProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Datos Personales',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: cuestionarioProvider.setName,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: cuestionarioProvider.setHeight,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: cuestionarioProvider.setWeight,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: cuestionarioProvider.gender,
              hint: const Text('Selecciona tu género'),
              items: ['Hombre', 'Mujer', 'Prefiero no decirlo']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: cuestionarioProvider.setGender,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalScreen(BuildContext context) {
    final cuestionarioProvider = Provider.of<CuestionarioProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/empecemos.json', height: 200),
            const SizedBox(height: 20),
            const Text(
              'Lo que enfrentamos puede parecer insuperable.\nPero aprendí algo de todas esas series y repeticiones cuando no pensé que podría levantar otra onza de peso.\nLo que aprendí es que siempre somos más fuertes de lo que pensamos.\n\n~Arnold Schwarzenegger',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              onPressed: () async {
                await cuestionarioProvider.saveData();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: const Text('Finalizar',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0047AB),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
