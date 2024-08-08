import 'package:flutter/material.dart';
import 'package:interview_flutter/providers/city_provider.dart';
import 'package:interview_flutter/screens/home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    //Anadimos el multiprovider al main para que toda la app se sincronice 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CityProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeScreen()
    );
  }
}