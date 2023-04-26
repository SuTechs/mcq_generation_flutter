import 'package:flutter/material.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';
import 'package:mcq_generation_flutter/data/data/data_box.dart';
import 'package:mcq_generation_flutter/screens/assesment/assesment.dart';
import 'package:mcq_generation_flutter/screens/course/add_course.dart';
import 'package:mcq_generation_flutter/screens/router_utils.dart';

class CourseDetailsScreen extends StatelessWidget {
  final bool isAdmin;
  final CourseData data;

  const CourseDetailsScreen(
      {Key? key, required this.data, required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Details"),
        centerTitle: false,
        actions: isAdmin
            ? [
                IconButton(
                    onPressed: () {
                      goTo(AddCourse(data: data), context);
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      DataBox.courseBox
                          .delete(data.key)
                          .then((value) => Navigator.pop(context));
                    },
                    icon: const Icon(Icons.delete))
              ]
            : null,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          goTo(AssessmentScreen(courseData: data), context);
        },
        label: const Text('Take assessment'),
        icon: const Icon(Icons.quiz_outlined),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  data.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.image_not_supported_outlined,
                    size: 100,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          data.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          data.courseContent,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        goTo(AssessmentScreen(courseData: data), context);
                      },
                      child: const Text('Take assessment'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
