import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
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

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  }

  Future<User?> signInWithGitHub() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    // Reemplaza `githubToken` con un token válido obtenido desde GitHub OAuth
    final String githubToken = 'your-github-token';
    final OAuthCredential githubAuthCredential =
        GithubAuthProvider.credential(githubToken);

    return (await auth.signInWithCredential(githubAuthCredential)).user;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isPortrait = constraints.maxHeight > constraints.maxWidth;

          return SingleChildScrollView(
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
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: textTheme.bodyMedium,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: textTheme.bodyMedium,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            User? user = await signInWithGoogle();
                            if (user != null) {
                              print('Google Sign-In Successful: ${user.email}');
                            }
                          },
                          icon: FaIcon(FontAwesomeIcons.google,
                              color: Colors.white),
                          label: Text(
                            'Google',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            User? user = await signInWithGitHub();
                            if (user != null) {
                              print('GitHub Sign-In Successful: ${user.email}');
                            }
                          },
                          icon: FaIcon(FontAwesomeIcons.github,
                              color: Colors.white),
                          label: Text(
                            'GitHub',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '¿No tienes cuenta? Regístrate',
                            style: textTheme.bodyMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: textTheme.bodyMedium,
                          ),
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
