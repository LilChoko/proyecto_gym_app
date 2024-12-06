import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panthers_gym/providers/theme_provider.dart';
import 'package:panthers_gym/providers/font_provider.dart';
import 'package:panthers_gym/screens/home_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  // Método para cargar los datos del usuario desde Firestore
  Future<Map<String, String>> _loadUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No se encontró al usuario.');
    }

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception('No se encontraron datos del usuario.');
      }

      final data = userDoc.data()!;
      return {
        'name': data['name'] ?? 'No proporcionado',
        'height': data['height']?.toString() ?? 'No proporcionado',
        'weight': data['weight']?.toString() ?? 'No proporcionado',
        'gender': data['gender'] ?? 'No proporcionado',
      };
    } catch (e) {
      throw Exception('Error al cargar los datos del usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return FutureBuilder<Map<String, String>>(
      future: _loadUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }

        final userInfo = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            title: Text(
              'Perfil',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  _showSettingsModal(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Imagen de fondo y avatar
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Imagen de fondo
                    Container(
                      height:
                          isLandscape ? size.height * 0.15 : size.height * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/gym_fondo2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Avatar encima de la imagen
                    Positioned(
                      bottom:
                          isLandscape ? -size.width * 0.03 : -size.width * 0.1,
                      left: size.width * 0.05,
                      child: CircleAvatar(
                        radius:
                            isLandscape ? size.width * 0.08 : size.width * 0.15,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'assets/avatar.jpg',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        isLandscape ? size.height * 0.05 : size.height * 0.15),
                // Contenido principal
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Título
                      Text(
                        'Tu Información',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Información del usuario
                      _buildUserInfoRow(
                        icon: Icons.person,
                        label: 'Nombre',
                        value: userInfo['name']!,
                        size: size,
                        isLandscape: isLandscape,
                        context: context,
                      ),
                      SizedBox(height: size.height * 0.015),
                      _buildUserInfoRow(
                        icon: Icons.height,
                        label: 'Altura',
                        value: '${userInfo['height']} cm',
                        size: size,
                        isLandscape: isLandscape,
                        context: context,
                      ),
                      SizedBox(height: size.height * 0.015),
                      _buildUserInfoRow(
                        icon: Icons.monitor_weight,
                        label: 'Peso',
                        value: '${userInfo['weight']} kg',
                        size: size,
                        isLandscape: isLandscape,
                        context: context,
                      ),
                      SizedBox(height: size.height * 0.015),
                      _buildUserInfoRow(
                        icon: Icons.transgender,
                        label: 'Género',
                        value: userInfo['gender']!,
                        size: size,
                        isLandscape: isLandscape,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget para mostrar la información del usuario
  Widget _buildUserInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Size size,
    required bool isLandscape,
    required BuildContext context,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: isLandscape ? size.width * 0.04 : size.width * 0.07,
        ),
        SizedBox(width: size.width * 0.04),
        Expanded(
          child: Text(
            '$label: $value',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  // Mostrar el modal para configuración de fuentes y temas
  void _showSettingsModal(BuildContext context) {
    final List<String> availableFonts = [
      'Roboto',
      'OpenSans',
      'Lobster',
      'Poppins',
      'Merriweather'
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        final fontProvider = Provider.of<FontProvider>(context, listen: false);
        final themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Configuraciones Visuales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Configurar Fuente',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: availableFonts.length,
                  itemBuilder: (context, index) {
                    final font = availableFonts[index];
                    final isSelected = font == fontProvider.selectedFont;

                    return ListTile(
                      title: Text(
                        font,
                        style: TextStyle(fontFamily: font),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check, color: Color(0xFF0047AB))
                          : null,
                      onTap: () {
                        fontProvider.saveFontPreference(font);
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Configurar Tema',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text('Tema de Día'),
                      trailing: themeProvider.themeMode == ThemeMode.light
                          ? Icon(Icons.check, color: Color(0xFF0047AB))
                          : null,
                      onTap: () {
                        themeProvider.saveThemePreference(false);
                      },
                    ),
                    ListTile(
                      title: Text('Tema de Noche'),
                      trailing: themeProvider.themeMode == ThemeMode.dark
                          ? Icon(Icons.check, color: Color(0xFF0047AB))
                          : null,
                      onTap: () {
                        themeProvider.saveThemePreference(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
