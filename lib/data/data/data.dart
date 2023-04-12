import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  UserData(this.name, this.email, this.password);
}

@HiveType(typeId: 1)
class CourseData extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String courseContent;

  CourseData({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.courseContent,
  });
}

class QuestionData {
  final String answerText;

  final List<String> options;

  final String questionText;

  QuestionData.fromJson(Map<String, dynamic> json)
      : answerText = json['answerText']!,
        options = List<String>.from(json['distractors']!)
          ..add(json['answerText']!)
          ..shuffle(),
        questionText = json['questionText']!;
}
