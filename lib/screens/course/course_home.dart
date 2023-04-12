import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';
import 'package:mcq_generation_flutter/data/data/data_box.dart';

class CourseHomeScreen extends StatelessWidget {
  final UserData userData;

  const CourseHomeScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intelligent E-Learning System'),
        actions: [
          /// user name
          Text('Welcome! ${userData.name}'),

          /// add course button
          if (userData.email == 'admin@admin.com')
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_box_outlined),
              label: const Text('Add Course'),
            ),

          /// logout button
          TextButton.icon(
            onPressed: () {
              DataBox.logout();
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<CourseData>>(
        valueListenable: DataBox.courseBox.listenable(),
        builder: (_, courseBox, __) {
          final courses = courseBox.values;

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: GridView.count(
              crossAxisCount: 4, // Set the number of items in a row
              mainAxisSpacing: 32.0, // Set the space between the rows
              crossAxisSpacing: 32.0, // Set the space between the columns
              children: [
                for (final c in courses) _CourseCardTile(data: c),
                for (final c in courses) _CourseCardTile(data: c),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CourseCardTile extends StatelessWidget {
  final CourseData data;

  const _CourseCardTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              data.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  data.description,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('View Course'),
            ),
          ),
        ],
      ),
    );
  }
}
