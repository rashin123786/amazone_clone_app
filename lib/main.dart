import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/data/datasource/auth_datasource.dart';
import 'package:test/src/data/datasource/cart_datasource.dart';
import 'package:test/src/data/datasource/product_datasource.dart';
import 'package:test/src/data/datasource/wishlist_datasource.dart';
import 'package:test/src/data/repositories/auth_repo_impl.dart';
import 'package:test/src/data/repositories/cart_repository_impl.dart';
import 'package:test/src/data/repositories/product_repo_impl.dart';
import 'package:test/src/data/repositories/wishlit_repo_impl.dart';
import 'package:test/src/domain/usecases/auth_usecases.dart';
import 'package:test/src/domain/usecases/product_usecases.dart';
import 'package:test/firebase_options.dart';
import 'package:test/src/presentation/provider/cart_controller.dart';
import 'package:test/src/presentation/provider/product_controller.dart';
import 'package:test/src/presentation/provider/auth_controller.dart';
import 'package:test/src/presentation/provider/wishlist_controller.dart';
import 'package:test/src/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(
            AuthUsecases(AuthRepositoryImpl(FirebaseAuthDatasource())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductController(
            GetProductsUsecase(
              ProductRepositoryImpl(ProductDatasource(firestore)),
            ),
          )..loadProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartController(
            CartRepositoryImpl(CartDatasource(FirebaseFirestore.instance)),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistController(
            WishlistRepositoryImpl(WishlistDatasource(firestore)),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black),
        primaryColor: Color(0xFFFFD814),
        buttonTheme: ButtonThemeData(buttonColor: Color(0xFFFFD814)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFD814)),
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: SplashScreen(),
    );
  }
}
// Platform  Firebase App Id
// web       1:565492441016:web:f093c5950e8863678ef94d
// android   1:565492441016:android:b34fff7f4fd556db8ef94d
// ios       1:565492441016:ios:1675533de2ae84c28ef94d