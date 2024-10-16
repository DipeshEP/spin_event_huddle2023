import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spin_event_2023/view/src/users%20.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBbi104_QooERL_XR3Ne8Lu_yiG6rjvbPY",
        appId: "1:168388114269:web:e4a65e0dd3b16213725ab4",
        messagingSenderId: "168388114269",
        projectId: "reachout-a0f92",
        measurementId: "G-JMT4Z1E8G0",
        storageBucket: "reachout-a0f92.appspot.com",
      ),
    );

    // Ensure that IndexedDB is used for persistence on web
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spin DashBoard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: Users(),  // Your Users screen as the home screen
    );
  }
}

// const firebaseConfig = {
//
//   // authDomain: "reachout-a0f92.firebaseapp.com",
//   // storageBucket: "reachout-a0f92.appspot.com",
//   // measurementId: "G-JMT4Z1E8G0"
// };

