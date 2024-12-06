import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:panthers_gym/providers/auth_provider.dart';
import 'cuestionario1_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ClipOval(
                  child: Image.asset(
                    'assets/panther_gym_logo.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () => _signIn(context, authProvider),
                  child: const Text('Iniciar sesión'),
                ),
                TextButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () => _register(context, authProvider),
                  child: const Text('¿No tienes cuenta? Regístrate'),
                ),
                TextButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () => _resetPassword(context, authProvider),
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
                TextButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () => _resendVerification(context, authProvider),
                  child: const Text('Reenviar confirmación de cuenta'),
                ),
              ],
            ),
          ),
          if (authProvider.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<void> _signIn(BuildContext context, AuthProvider authProvider) async {
    try {
      // Redirección basada en el estado del cuestionario ya manejado en signInWithEmail
      await authProvider.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        context, // Pasamos el contexto para manejar las rutas en AuthProvider
      );
    } catch (e) {
      // Mostrar mensaje de error si ocurre alguna excepción
      _showMessage(context, e.toString());
    }
  }

  Future<void> _register(
      BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.registerWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      _showMessage(
          context, 'Registro exitoso. Verifica tu correo electrónico.');
    } catch (e) {
      _showMessage(context, e.toString());
    }
  }

  Future<void> _resetPassword(
      BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.resetPassword(_emailController.text.trim());
      _showMessage(context, 'Correo de restablecimiento enviado.');
    } catch (e) {
      _showMessage(context, e.toString());
    }
  }

  Future<void> _resendVerification(
      BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.resendVerificationEmail();
      _showMessage(context, 'Correo de verificación reenviado.');
    } catch (e) {
      _showMessage(context, e.toString());
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
