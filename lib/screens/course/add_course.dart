import 'package:flutter/material.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';
import 'package:mcq_generation_flutter/data/data/data_box.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _imageUrlCtrl = TextEditingController();
  final _courseContentCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Course"),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'images/illustration-1.png',
                        fit: BoxFit.fitHeight,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image,
                          size: 400,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )),
                ),
              ),

              /// form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// name
                        TextFormField(
                          controller: _nameCtrl,
                          validator: (s) {
                            if (s == null) return 'Enter a name';
                            if (s.trim().isEmpty) return 'Enter a name';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter name',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: const TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// description
                        TextFormField(
                          controller: _descCtrl,
                          validator: (s) {
                            if (s == null) return 'Enter a description';
                            if (s.trim().isEmpty) return 'Enter a description';
                            return null;
                          },
                          minLines: 3,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Enter description',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: const TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// image url
                        TextFormField(
                          controller: _imageUrlCtrl,
                          validator: (s) {
                            if (s == null) return 'Enter an image url';
                            if (s.trim().isEmpty) return 'Enter an image url';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter an image url',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: const TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        ///  course content
                        TextFormField(
                          controller: _courseContentCtrl,
                          minLines: 8,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          validator: (s) {
                            if (s == null) return 'Enter course content';
                            if (s.trim().isEmpty) return 'Enter course content';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter course content',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: const TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[50]!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// submit button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple[100]!,
                                spreadRadius: 10,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _onButtonPressed,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text('Submit'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _onButtonPressed() {
    final validated = _formKey.currentState?.validate() ?? false;
    if (!validated) return;

    final CourseData c = CourseData(
      name: _nameCtrl.text,
      description: _descCtrl.text,
      imageUrl: _imageUrlCtrl.text,
      courseContent: _courseContentCtrl.text,
    );

    DataBox.courseBox.add(c);

    Navigator.pop(context);
  }
}
