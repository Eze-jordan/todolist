import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/compte/login.dart';
import 'package:todo_list/screens/contenu/firstpage.dart';

class Timepage extends StatefulWidget {
  const Timepage({super.key});

  @override
  State<Timepage> createState() => _TimepageState();
}

class _TimepageState extends State<Timepage> {
  @override
  void initState() {
    super.initState();
    // Définir un timer pour naviguer vers la prochaine page après 5 secondes
    // Naviguer vers la première page après 1 seconde
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data != null) {
                    return const Firstpage();
                  }
                  return const Login();
                })),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEDBDB),
      body: Column(
        children: [
          const Spacer(), // Espace vide au-dessus de l'image pour la centrer
          // Image au centre de l'écran
          Center(
            child: Image.asset(
              'assets/img/LOGO3.png',
              width: 300, // Ajuste la taille si nécessaire
              height: 300,
            ),
          ),
          const Spacer(), // Espace vide sous l'image pour la centrer
          // Texte tout en bas de l'écran
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'TodoList',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w900,
                fontFamily: 'PTSans',
                color: Color(0xFF050505),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: const LinearProgressIndicator(
              backgroundColor: Color(0xFFDCDCDC),
              color: Color(0xFF2C65C7), // Changer la couleur si nécessaire
            ),
          ),
        ],
      ),
    );
  }
}
