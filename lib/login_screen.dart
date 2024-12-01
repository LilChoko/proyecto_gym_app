import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0047AB), // Azul cobalto
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Detecta orientación y espacio disponible
          bool isPortrait = constraints.maxHeight > constraints.maxWidth;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // Limita el alto mínimo
              ),
              child: IntrinsicHeight(
                // Ajusta los hijos al contenido total
                child: Column(
                  mainAxisAlignment: isPortrait
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: isPortrait ? 20 : 0),
                    // Logo redondeado
                    ClipOval(
                      child: Image.asset(
                        'assets/panther_gym_logo.png', // Reemplaza con la ruta de tu logo
                        height: isPortrait ? 100 : 80,
                        width: isPortrait ? 100 : 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: isPortrait ? 40 : 20),
                    // Campo de correo
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Campo de contraseña
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Botones de Google y Facebook
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.google,
                              color: Colors.white),
                          label: Text('Google'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.facebookF,
                              color: Colors.white),
                          label: Text('Facebook'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Botón de GitHub
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon:
                          FaIcon(FontAwesomeIcons.github, color: Colors.white),
                      label: Text('GitHub'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Spacer(),
                    // Botones de texto centrados
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('¿Olvidaste tu contraseña?'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('¿No tienes cuenta? Regístrate'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
