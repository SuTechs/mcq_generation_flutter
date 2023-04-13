import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mcq_generation_flutter/data/api/api.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';

class AssessmentScreen extends StatefulWidget {
  final CourseData courseData;

  const AssessmentScreen({Key? key, required this.courseData})
      : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  List<QuestionData> _dataList = [];
  bool _isLoading = true;

  int _currentScore = 0;

  @override
  void initState() {
    _fetchQuestions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseData.name} Assessment'),
      ),
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: () =>
                  _showResultDialog(_dataList.length, _currentScore),
              label: const Text("Submit"),
              icon: const Icon(Icons.check),
            ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.3),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int index = 0; index < _dataList.length; index++)
                      QuestionTile(
                        question: _dataList[index],
                        onScoreChange: (qs) {
                          if (qs < 0) return;

                          _currentScore += qs;
                        },
                        questionIndex: index + 1,
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  void _fetchQuestions() async {
    _dataList = await Api.getQuestionData(widget.courseData.courseContent);
    setState(() {
      _isLoading = false;
    });
  }

  _showResultDialog(int totalScore, int achievedScore) {
    String message;
    if (achievedScore / totalScore < 0.6) {
      message =
          'Please go through the course again, your score is less than average.\n\n';
    } else {
      message = 'Well done!\n\n';
    }
    message += 'Maximum Score: $totalScore\nYour Score: $achievedScore';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assessment Result'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class QuestionTile extends StatefulWidget {
  final QuestionData question;
  final int questionIndex;
  final void Function(int) onScoreChange;

  const QuestionTile({
    super.key,
    required this.question,
    required this.onScoreChange,
    required this.questionIndex,
  });

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  String? _selectedAnswer;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32.0),
          Text(
            '${widget.questionIndex}. ${widget.question.questionText}',
            style: textTheme.bodyLarge?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          ...List.generate(
              widget.question.options.length,
              (index) => Option(
                    optionText: widget.question.options[index],
                    index: index,
                    selectedOption: _selectedAnswer,
                    onChanged: _checkAns,
                  )),
        ],
      ),
    );
  }

  void _checkAns(String? newAnswer) {
    setState(() {
      _selectedAnswer = newAnswer;
    });

    if (_selectedAnswer == null) return;

    if (_selectedAnswer == widget.question.answerText) {
      widget.onScoreChange(1);
      if (kDebugMode) {
        print('Correct Answer');
      }
    } else {
      widget.onScoreChange(0);
      if (kDebugMode) {
        print('Correct Answer');
      }
    }
  }
}

class Option extends StatelessWidget {
  final String optionText;
  final String? selectedOption;
  final int index;
  final ValueChanged<String?>? onChanged;

  const Option({
    super.key,
    required this.optionText,
    required this.index,
    this.selectedOption,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 9),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: RadioListTile(
        title: Text("${index + 1}. $optionText"),
        value: optionText,
        groupValue: selectedOption,
        onChanged: onChanged,
      ),
    );
  }
}
