import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:panthers_gym/providers/peso_provider.dart';
import 'home_screen.dart';

class PesoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pesoProvider = Provider.of<PesoProvider>(context);
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
          'Control de Peso',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: isLandscape ? size.width * 0.035 : size.width * 0.05,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.scale_rounded, color: Colors.white),
            onPressed: () {
              _showAddWeightModal(context, size, isLandscape, pesoProvider);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Historial de Peso',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize:
                        isLandscape ? size.width * 0.03 : size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            Center(
              child: Lottie.asset(
                'assets/lotties/bascula.json',
                height: isLandscape ? size.height * 0.15 : size.height * 0.3,
                width: size.width * 0.5,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: pesoProvider.historialPeso.isEmpty
                  ? Center(
                      child: Text(
                        'No hay registros aún',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: isLandscape
                                  ? size.width * 0.03
                                  : size.width * 0.04,
                              color: Colors.grey,
                            ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: pesoProvider.historialPeso.length,
                      itemBuilder: (context, index) {
                        final registro = pesoProvider.historialPeso[index];
                        return _buildDismissibleCard(
                          context,
                          size,
                          isLandscape,
                          index,
                          registro,
                          pesoProvider,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDismissibleCard(
    BuildContext context,
    Size size,
    bool isLandscape,
    int index,
    Map<String, String> registro,
    PesoProvider pesoProvider,
  ) {
    return Dismissible(
      key: Key(registro['fecha']! + registro['peso']!),
      direction: DismissDirection.endToStart,
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
        pesoProvider.eliminarPeso(index);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro eliminado')),
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
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                        size.width * (isLandscape ? 0.015 : 0.02)),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.scale_rounded,
                      color: Theme.of(context).primaryColor,
                      size: size.width * (isLandscape ? 0.04 : 0.06),
                    ),
                  ),
                  SizedBox(width: size.width * (isLandscape ? 0.02 : 0.03)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha: ${registro['fecha']!}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize:
                                  size.width * (isLandscape ? 0.03 : 0.04),
                            ),
                      ),
                      Text(
                        'Peso: ${registro['peso']} Kg',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize:
                                  size.width * (isLandscape ? 0.03 : 0.04),
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

  void _showAddWeightModal(BuildContext context, Size size, bool isLandscape,
      PesoProvider pesoProvider) {
    final _pesoController = TextEditingController();
    DateTime? _selectedDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
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
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: isLandscape
                            ? size.width * 0.035
                            : size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                SizedBox(height: size.height * 0.02),
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      _selectedDate = pickedDate;
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        Icon(Icons.calendar_today,
                            color: Theme.of(context).primaryColor),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                  controller: _pesoController,
                  decoration: const InputDecoration(
                    labelText: 'Peso (Kg)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.03),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedDate != null &&
                        _pesoController.text.isNotEmpty) {
                      pesoProvider.agregarPeso(
                          _selectedDate!, _pesoController.text);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.2,
                      vertical: size.height * (isLandscape ? 0.015 : 0.02),
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: isLandscape
                              ? size.width * 0.03
                              : size.width * 0.045,
                        ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }

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
                'assets/lotties/borrar.json',
                height: 100,
                width: 100,
              ),
              const Text('¿Eliminar registro?'),
            ],
          ),
          content: const Text('Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
