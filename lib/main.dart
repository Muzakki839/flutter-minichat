import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:minichat/data/contacts_data.dart';
import 'package:minichat/services/auth/auth_gate.dart';
import 'package:minichat/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init firebasa
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // init hive
  await Hive.initFlutter();
  await Hive.openBox("dataBox");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // init contacts data
  static ContactsData contactsData = ContactsData();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // get the opened hive box
  final Box _dataBox = Hive.box('dataBox');
  // get contactsData
  final _contactsData = MyApp.contactsData;

  @override
  void initState() {
    // init data if db is null
    if (_dataBox.get("CONTACTS") == null) {
      _contactsData.createInitialData();
    } else {
      _contactsData.getData();
    }

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade900,
          brightness: Brightness.light,
          dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
        ),
        useMaterial3: true,
      ),
      home: AuthGate(),
    );
  }
}
