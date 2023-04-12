import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';
import 'package:mcq_generation_flutter/data/data/data_box.dart';
import 'package:mcq_generation_flutter/screens/course/course_home.dart';
import 'package:mcq_generation_flutter/screens/login/login.dart';

void main() async {
  await DataBox.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intelligent eLearning System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserData>>(
      valueListenable: DataBox.loggedInUserListenable,
      builder: (_, loggedInUserBox, __) {
        final loggedInUser = loggedInUserBox.get(DataBox.loggedInUserKey);

        if (loggedInUser == null) return const LoginScreen();

        return CourseHomeScreen(userData: loggedInUser);
      },
    );
  }
}
