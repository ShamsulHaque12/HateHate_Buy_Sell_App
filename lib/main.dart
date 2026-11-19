import 'package:flutter/material.dart';

import 'app.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await di.init();

  runApp(const MyApp());
}
