import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/domain/entities/user_entity.dart';
import 'package:test/src/presentation/provider/auth_controller.dart';
import 'package:test/src/presentation/screens/home_screen.dart';
import 'package:test/src/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final auth = Provider.of<AuthController>(context, listen: false);
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          }
          auth.currentUser = UserEntity(
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName,
            photoUrl: user.photoURL,
          );
          return HomeScreen();
        }
        return Scaffold(
          body: Center(
            child: CachedNetworkImage(
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
              errorWidget: (context, url, error) => SizedBox(),
            ),
          ),
        );
      },
    );
  }
}
