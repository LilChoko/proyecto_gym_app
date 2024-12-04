import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(email);
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este correo ya está registrado.';
      case 'invalid-email':
        return 'El correo introducido no es válido.';
      case 'weak-password':
        return 'La contraseña es muy débil.';
      case 'user-not-found':
        return 'No se encontró ningún usuario con este correo.';
      case 'wrong-password':
        return 'La contraseña es incorrecta.';
      default:
        return 'Ocurrió un error. Inténtalo nuevamente.';
    }
  }

  Future<void> _registerWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (!_isValidEmail(email)) {
      _showMessage('Por favor, introduce un correo válido.');
      return;
    }

    if (password.isEmpty) {
      _showMessage('La contraseña no puede estar vacía.');
      return;
    }

    _setLoading(true);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        _showMessage(
          'Se ha enviado un correo de verificación a $email. Por favor, verifica tu cuenta antes de iniciar sesión.',
        );
      }
    } on FirebaseAuthException catch (e) {
      _showMessage(_getFirebaseAuthErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _signInWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (!_isValidEmail(email)) {
      _showMessage('Por favor, introduce un correo válido.');
      return;
    }

    if (password.isEmpty) {
      _showMessage('La contraseña no puede estar vacía.');
      return;
    }

    _setLoading(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!userCredential.user!.emailVerified) {
        _showMessage(
          'Tu correo no está verificado. Por favor, revisa tu bandeja de entrada.',
        );
      } else {
        _showMessage('Inicio de sesión exitoso.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showMessage(_getFirebaseAuthErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _sendPasswordReset() async {
    final email = _emailController.text.trim();

    if (!_isValidEmail(email)) {
      _showMessage('Por favor, introduce un correo válido.');
      return;
    }

    _setLoading(true);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showMessage(
        'Se ha enviado un correo para restablecer tu contraseña a $email.',
      );
    } on FirebaseAuthException catch (e) {
      _showMessage(_getFirebaseAuthErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _resendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        _showMessage('Correo de verificación reenviado a ${user.email}.');
      } else {
        _showMessage('El usuario ya está verificado o no está autenticado.');
      }
    } catch (e) {
      _showMessage('Error al reenviar correo de verificación.');
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return (await _auth.signInWithCredential(credential)).user;
  }

  Future<void> _showMessage(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isPortrait = constraints.maxHeight > constraints.maxWidth;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: isPortrait
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: isPortrait ? 20 : 0),
                        ClipOval(
                          child: Image.asset(
                            'assets/panther_gym_logo.png',
                            height: isPortrait ? 100 : 80,
                            width: isPortrait ? 100 : 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: isPortrait ? 40 : 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: textTheme.bodyMedium,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: textTheme.bodyMedium,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _signInWithEmail,
                          child: Text('Iniciar sesión'),
                        ),
                        TextButton(
                          onPressed: _isLoading ? null : _registerWithEmail,
                          child: Text('¿No tienes cuenta? Regístrate'),
                        ),
                        TextButton(
                          onPressed: _isLoading ? null : _sendPasswordReset,
                          child: Text('¿Olvidaste tu contraseña?'),
                        ),
                        TextButton(
                          onPressed:
                              _isLoading ? null : _resendVerificationEmail,
                          child: Text('Reenviar confirmación de cuenta'),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      User? user = await signInWithGoogle();
                                      if (user != null) {
                                        print(
                                            'Google Sign-In Successful: ${user.email}');
                                      }
                                    },
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
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
