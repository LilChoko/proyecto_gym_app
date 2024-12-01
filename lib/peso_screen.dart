import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:panthers_gym/home_screen.dart';

class PesoScreen extends StatefulWidget {
  @override
  _PesoScreenState createState() => _PesoScreenState();
}

class _PesoScreenState extends State<PesoScreen> {
  final List<Map<String, String>> _historialPeso = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

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
          'Control de Peso',
          style: TextStyle(
            color: Colors.white,
            fontSize: isLandscape ? size.width * 0.035 : size.width * 0.05,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.scale_rounded, color: Colors.white),
            onPressed: () {
              _showAddWeightModal(context, size, isLandscape);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            Text(
              'Historial de Peso',
              style: TextStyle(
                fontSize: isLandscape ? size.width * 0.03 : size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0047AB),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),

            // Animación Lottie
            Center(
              child: Lottie.asset(
                'assets/bascula.json',
                height: isLandscape ? size.height * 0.15 : size.height * 0.3,
                width: size.width * 0.5,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: size.height * 0.03),

            // Lista de registros dinámicos
            Expanded(
              child: _historialPeso.isEmpty
                  ? Center(
                      child: Text(
                        'No hay registros aún',
                        style: TextStyle(
                          fontSize: isLandscape
                              ? size.width * 0.03
                              : size.width * 0.04,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _historialPeso.length,
                      itemBuilder: (context, index) {
                        final registro = _historialPeso[index];
                        return _buildDismissibleCard(
                            context, size, isLandscape, index, registro);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Construir tarjeta de registro con deslizable
  Widget _buildDismissibleCard(BuildContext context, Size size,
      bool isLandscape, int index, Map<String, String> registro) {
    return Dismissible(
      key: Key(registro['fecha']! + registro['peso']!),
      direction: DismissDirection.endToStart, // Deslizar de derecha a izquierda
      background: Container(
        margin: EdgeInsets.symmetric(vertical: isLandscape ? 3 : 5),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: size.width * 0.05),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: size.width * 0.07,
        ),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmation(context);
      },
      onDismissed: (direction) {
        setState(() {
          _historialPeso.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro eliminado')),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: isLandscape ? 3 : 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width * (isLandscape ? 0.02 : 0.03)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Ícono y texto del registro
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                        size.width * (isLandscape ? 0.015 : 0.02)),
                    decoration: BoxDecoration(
                      color: Color(0xFF0047AB).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.scale_rounded,
                      color: Color(0xFF0047AB),
                      size: size.width * (isLandscape ? 0.04 : 0.06),
                    ),
                  ),
                  SizedBox(width: size.width * (isLandscape ? 0.02 : 0.03)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha: ${registro['fecha']!}',
                        style: TextStyle(
                          fontSize: size.width * (isLandscape ? 0.03 : 0.04),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Peso: ${registro['peso']} Kg',
                        style: TextStyle(
                          fontSize: size.width * (isLandscape ? 0.03 : 0.04),
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mostrar el cuadro modal para agregar un nuevo peso
  void _showAddWeightModal(BuildContext context, Size size, bool isLandscape) {
    final _pesoController = TextEditingController();
    DateTime? _selectedDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Permite que el modal sea desplazable
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
                  'Agregar Nuevo Peso',
                  style: TextStyle(
                    fontSize:
                        isLandscape ? size.width * 0.035 : size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0047AB),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                // Selector de fecha
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.015,
                      horizontal: size.width * 0.03,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate != null
                              ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                              : 'Seleccionar Fecha',
                          style: TextStyle(
                            fontSize: isLandscape
                                ? size.width * 0.035
                                : size.width * 0.04,
                            color: Colors.black54,
                          ),
                        ),
                        Icon(Icons.calendar_today, color: Color(0xFF0047AB)),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                // Campo para ingresar peso
                TextField(
                  controller: _pesoController,
                  decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: size.height * 0.03),

                // Botón para guardar
                ElevatedButton(
                  onPressed: () {
                    if (_selectedDate != null &&
                        _pesoController.text.isNotEmpty) {
                      setState(() {
                        _historialPeso.add({
                          'fecha':
                              DateFormat('dd/MM/yyyy').format(_selectedDate!),
                          'peso': _pesoController.text,
                        });
                      });
                      Navigator.pop(context); // Cerrar el modal
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0047AB),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.2,
                      vertical: size.height * (isLandscape ? 0.015 : 0.02),
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          isLandscape ? size.width * 0.03 : size.width * 0.045,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02), // Espaciado inferior
              ],
            ),
          ),
        );
      },
    );
  }

  // Mostrar cuadro de confirmación para eliminar
  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Column(
            children: [
              Lottie.asset(
                'assets/borrar.json',
                height: 100,
                width: 100,
              ),
              Text('¿Eliminar registro?'),
            ],
          ),
          content: Text('Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
