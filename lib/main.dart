import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'views/home_screen.dart';
import 'models/task_model.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

   // Initialize Hive
  await Hive.initFlutter();
  
  // Register TaskModelAdapter if it's not already registered
  if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }
  
  // Open the box
  await Hive.openBox<TaskModel>('tasks');

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  // Initialize local notifications
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          cardColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          cardColor: Colors.grey[850],
          scaffoldBackgroundColor: Colors.black,
        ),
        themeMode: ThemeMode.system, // Automatically detect the system theme
        home: HomeScreen(),
      ),
    );
  }
}
