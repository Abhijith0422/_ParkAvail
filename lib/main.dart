// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getit<ParkdataBloc>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ParkAvail',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
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
        ),
        home: const AuthPage(),
      ),
    );
  }
}
