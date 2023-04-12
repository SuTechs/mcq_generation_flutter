import 'package:flutter/material.dart';
import 'package:mcq_generation_flutter/data/api/api.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';

var currScore = 0;

class AssessmentScreen extends StatefulWidget {
  final CourseData courseData;

  const AssessmentScreen({Key? key, required this.courseData})
      : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  List<QuestionData> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchQuestions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Submit"),
              icon: const Icon(Icons.check),
            ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return QuestionTile(question: dataList[index]);
              },
              itemCount: dataList.length,
            ),
    );
  }

  void fetchQuestions() async {
    dataList = await getQuestionData();
    setState(() {
      isLoading = false;
    });
  }
}

class QuestionTile extends StatelessWidget {
  final QuestionData question;

  const QuestionTile({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 32.0,
            ),
            Text(
              question.questionText,
              style: textTheme.bodyLarge?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            ...List.generate(
                question.options.length,
                (index) => Option(
                      optionText: question.options[index],
                      index: index,
                      onOptionTap: () => checkAns(question, index),
                      isAns: question.options[index] == question.answerText,
                    )),
          ],
        ),
      ),
    );
  }

  bool checkAns(QuestionData question, int index) {
    if (question.answerText == question.options[index]) {
      currScore++;
      print(currScore);
      return true;
    } else {
      print("Wrong answer");
      return false;
    }
  }
}

enum OptionStatus { UnAnswered, Right, Wrong }

class Option extends StatefulWidget {
  final String optionText;
  final int index;
  final bool isAns;
  final VoidCallback onOptionTap;

  const Option(
      {super.key,
      required this.optionText,
      required this.index,
      required this.onOptionTap,
      required this.isAns});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  var currOptionStatus = OptionStatus.UnAnswered;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        widget.onOptionTap();
        if (widget.isAns) {
          currOptionStatus = OptionStatus.Right;
        } else {
          currOptionStatus = OptionStatus.Wrong;
        }
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 9),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "${widget.index + 1}. ${widget.optionText}",
                style: textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 26,
              width: 26,
              child: (currOptionStatus == OptionStatus.UnAnswered)
                  ? const Icon(
                      Icons.circle_outlined,
                      size: 16,
                      color: Colors.grey,
                    )
                  : (currOptionStatus == OptionStatus.Right)
                      ? const Icon(
                          Icons.circle,
                          size: 16,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.circle,
                          size: 16,
                          color: Colors.red,
                        ),
            )
          ],
        ),
      ),
    );
  }
}
