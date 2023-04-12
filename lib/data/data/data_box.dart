import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';

class DataBox {
  static const _userKey = 'users';
  static const _curseKey = 'courses';
  static const loggedInUserKey = 'loggedInUser';

  static Box<UserData> userBox = Hive.box<UserData>(_userKey);
  static Box<CourseData> courseBox = Hive.box<CourseData>(_curseKey);

  static ValueListenable<Box<UserData>> get loggedInUserListenable =>
      userBox.listenable(keys: [loggedInUserKey]);

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(CourseDataAdapter());

    /// opening box

    await Hive.openBox<UserData>(_userKey);
    await Hive.openBox<CourseData>(_curseKey);

    /// add some pre-data

    // adding admin
    userBox.put(
        'admin@admin.com', UserData('Admin', 'admin@admin.com', 'admin123'));

    // adding course

    if (courseBox.isEmpty) {
      for (final c in _courses) {
        courseBox.put(c.name, c);
      }
    }
  }

  /// some helper methods for users

  static void login(UserData userData) => userBox.put(loggedInUserKey,
      UserData(userData.name, userData.email, userData.password));

  static void logout() => userBox.delete(loggedInUserKey);

  static UserData? getUserByEmail(String email) => userBox.get(email);

  static void signup(UserData userData) {
    userBox.put(userData.email, userData);
    login(userData);
  }
}

/// course data
List<CourseData> _courses = [
  CourseData(
    name: 'Introduction to Programming',
    description: 'Learn the basics of programming with Python',
    imageUrl: 'https://picsum.photos/200',
    courseContent:
        'Programming is the process of designing, writing, testing, and maintaining computer programs. It is a critical skill for anyone interested in technology, science, or engineering. In this course, we will learn the basics of programming using Python, a popular programming language known for its simplicity and readability. We will cover fundamental programming concepts such as variables, data types, control structures, and functions. By the end of the course, you will have a solid foundation in programming that will prepare you for more advanced topics and projects.',
  ),
  CourseData(
    name: 'Web Development Fundamentals',
    description:
        'Learn the basics of web development with HTML, CSS, and JavaScript',
    imageUrl: 'https://picsum.photos/200',
    courseContent:
        'Web development is the process of creating websites and web applications. It involves a combination of programming, design, and communication skills. In this course, we will cover the fundamentals of web development using HTML, CSS, and JavaScript, the three core technologies used to build websites. We will start with the basics of HTML, including tags, attributes, and document structure. Next, we will move on to CSS, where we will learn how to style our HTML documents with colors, fonts, and layout. Finally, we will explore JavaScript, a powerful programming language used to create dynamic and interactive web applications. By the end of the course, you will have a solid understanding of the fundamentals of web development and be able to build your own simple web pages and applications.',
  ),
  CourseData(
    name: 'Data Science Essentials',
    description: 'Learn the basics of data science with Python and Pandas',
    imageUrl: 'https://picsum.photos/200',
    courseContent:
        'Data science is the process of using data to gain insights and knowledge. It is a critical skill for anyone interested in business, finance, or technology. In this course, we will cover the basics of data science using Python and Pandas, a powerful data analysis library. We will start by learning how to load and manipulate data using Pandas. Next, we will explore different ways to visualize data, such as histograms and scatter plots. Finally, we will introduce some basic statistical concepts and techniques for data analysis. By the end of the course, you will have a solid foundation in data science that will prepare you for more advanced topics and projects.',
  ),
];
