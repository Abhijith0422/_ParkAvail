<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:async';
=======
// ignore_for_file: use_build_context_synchronously

import 'package:book_my_park/application/bloc/parkdata_bloc.dart';
import 'package:book_my_park/domain/core/injectable.dart';
import 'package:book_my_park/presentation/auth.dart';
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD

import 'package:supabase_flutter/supabase_flutter.dart';
import 'application/bloc/parkdata_bloc.dart';
import 'domain/api/apiendpoints.dart';
import 'domain/core/injectable.dart';
import 'firebase_options.dart';
import 'infrastructure/supabase.dart';
import 'presentation/auth.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'ParkAvail',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Supabase.initialize(url: zupaurl, anonKey: zupakey);
    await configureInjection();
    Timer.periodic(const Duration(minutes: 5), (_) {
      SupabaseImageService().refreshImageUrl('your_image_path');
    });
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing app: $e');
    // Handle initialization error appropriately
  }
=======
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureInjection();
  runApp(const MyApp());
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
<<<<<<< HEAD
      providers: [BlocProvider(create: (context) => getit<ParkdataBloc>())],
=======
      providers: [
        BlocProvider(create: (context) => getit<ParkdataBloc>()),
      ],
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ParkAvail',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
<<<<<<< HEAD
            seedColor: const Color(0xFFdc3558), // BookMyShow primary red
            brightness: Brightness.dark,
            background: const Color(0xFF1f2533), // Dark blue-grey
            surface: const Color(0xFF2b3544), // Slightly lighter blue-grey
            primary: const Color(0xFFdc3558), // BookMyShow red
            secondary: const Color(0xFF2784e6), // BookMyShow blue
          ),
          scaffoldBackgroundColor: const Color(0xFF1f2533),
          useMaterial3: true,
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFdc3558),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
=======
              seedColor: const Color.fromARGB(255, 46, 197, 222)),
          useMaterial3: true,
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
        ),
        home: const AuthPage(),
      ),
    );
  }
}
