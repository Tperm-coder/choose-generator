import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/components/widgets/custom_button.dart';
import 'package:untitled/constants/my_colors.dart';
import 'package:untitled/pages/questions_page/question_page_provider.dart';
import 'package:untitled/widgets/custom_text.dart';

class QuestionsPage extends StatelessWidget {
  static String route = "/questionPage";
  final List<dynamic> json;
  const QuestionsPage({
    Key? key,
    required this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestionPageProvider(
        json: json,
      ),
      child: const QuestionsPageBody(),
    );
  }
}

class QuestionsPageBody extends StatelessWidget {
  const QuestionsPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionPageProvider>(
      builder: (_, provider, __) => Scaffold(
        backgroundColor: MyColors.cardColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 25,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * (90 / 100),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (int i = 0; i < provider.json.length; i++)
                        QuestionCard(
                          question: provider.json[i]["question"],
                          answers: provider.json[i]["answers"],
                          onChoose: (int choosedAnswerIndex) {
                            provider.updateAnswer(i, choosedAnswerIndex);
                          },
                          choosedAnswerIndex: provider.choosedAnswers[i] ?? -1,
                          showCorrectAnswer: provider.showCorrectAnswer,
                          correctAnswer: provider.json[i]["answers"]
                              [provider.json[i]["correctAnswer"] - 1],
                        )
                    ],
                  ),
                ),
              ),
              CustomSimpleButton(
                onPress: () {
                  provider.toggleShowAnswersState();
                },
                label: ("check answers"),
                fontSize: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final String question;
  final String correctAnswer;
  final List<dynamic> answers;
  final Function onChoose;
  final int choosedAnswerIndex;
  final bool showCorrectAnswer;
  const QuestionCard({
    Key? key,
    required this.showCorrectAnswer,
    required this.answers,
    required this.question,
    required this.onChoose,
    required this.choosedAnswerIndex,
    required this.correctAnswer,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              MyText.drawText(
                content: widget.question,
                bold: true,
                fontColor: MyColors.fontColor,
                fontSize: 25,
              ),
              Column(
                children: [
                  for (int i = 0; i < widget.answers.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      child: InkWell(
                        onTap: () {
                          widget.onChoose(i);
                        },
                        child: Row(
                          children: [
                            Icon(
                              (i == widget.choosedAnswerIndex)
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: widget.showCorrectAnswer
                                  ? (widget.answers[i] == widget.correctAnswer)
                                      ? Colors.green.shade200
                                      : Colors.red.shade200
                                  : (i == widget.choosedAnswerIndex)
                                      ? MyColors.selectedColor
                                      : MyColors.fontColor,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            MyText.drawText(
                              content: widget.answers[i],
                              bold: true,
                              fontColor: widget.showCorrectAnswer
                                  ? (widget.answers[i] == widget.correctAnswer)
                                      ? Colors.green.shade200
                                      : Colors.red.shade200
                                  : (i == widget.choosedAnswerIndex)
                                      ? MyColors.selectedColor
                                      : MyColors.fontColor,
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              widget.showCorrectAnswer
                  ? Center(
                      child: MyText.drawText(
                        content: "Correct Answer : ${widget.correctAnswer}",
                        bold: true,
                        fontColor: MyColors.fontColor,
                        fontSize: 20,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
