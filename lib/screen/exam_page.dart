import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int answeredCount = 0;
  bool showAllExplanations = false;

  final ScrollController _scrollController = ScrollController();
  bool _showSubmitButton = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Choose the correct sentence:",
      "options": [
        "She don’t like apples.",
        "She doesn’t like apples.",
        "She didn’t likes apples.",
        "She doesn’t likes apples.",
      ],
      "answer": 1,
      "explanation":
          "Correct: 'She doesn’t like apples.' because 'doesn't' is used with base verb.",
    },
    {
      "question": "What is the synonym of 'happy'?",
      "options": ["Sad", "Joyful", "Angry", "Tired"],
      "answer": 1,
      "explanation": "'Joyful' is the closest synonym of 'happy'.",
    },
    {
      "question": "Which word is a noun?",
      "options": ["Run", "Quickly", "Book", "Blue"],
      "answer": 2,
      "explanation":
          "'Book' is a noun. The others are verb, adverb, and adjective.",
    },
    {
      "question": "Which sentence is in past tense?",
      "options": [
        "I go to school.",
        "I will go to school.",
        "I went to school.",
        "I am going to school.",
      ],
      "answer": 2,
      "explanation": "'I went to school.' is past tense.",
    },
    {
      "question": "What is the opposite of 'difficult'?",
      "options": ["Easy", "Hard", "Complicated", "Tough"],
      "answer": 0,
      "explanation": "The opposite of 'difficult' is 'easy'.",
    },
  ];

  final Map<int, int> selectedAnswers = {};
  final Map<int, bool> showExplanation = {};

  void selectAnswer(int qIndex, int optionIndex) {
    if (selectedAnswers.containsKey(qIndex)) return;

    setState(() {
      selectedAnswers[qIndex] = optionIndex;
      answeredCount++;
    });
  }

  void toggleExplanation(int qIndex) {
    setState(() {
      showExplanation[qIndex] = !(showExplanation[qIndex] ?? false);
    });
  }

  void toggleAllExplanations(bool value) {
    setState(() {
      showAllExplanations = value;
      for (int i = 0; i < questions.length; i++) {
        showExplanation[i] = value;
      }
    });
  }

  void showExplanationsOnly() {
    setState(() {
      showAllExplanations = true; 
      for (int i = 0; i < questions.length; i++) {
        showExplanation[i] = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !_showSubmitButton) {
        setState(() {
          _showSubmitButton = true;
        });
      } else if (_scrollController.offset <= 50 && _showSubmitButton) {
        setState(() {
          _showSubmitButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = answeredCount / questions.length;

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz"), centerTitle: true),
      body: Column(
        children: [
          // Progress + Toggle Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // ✅ aligns tops
              children: [
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Questions $answeredCount/${questions.length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 12,
                          backgroundColor: Colors.grey[300],
                          color: const Color(0xFFB8860B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Show Exp. Right Away",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF006400),
                      ),
                    ),
                    Switch(
                      value: showAllExplanations,
                      activeColor: const Color(0xFF006400),
                      onChanged: toggleAllExplanations,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quiz Questions List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: questions.length,
              itemBuilder: (context, qIndex) {
                final question = questions[qIndex];
                final List<String> options = List<String>.from(
                  question["options"],
                );
                final correctIndex =
                    int.tryParse(question["answer"].toString()) ?? 0;
                final selectedIndex = selectedAnswers[qIndex];

                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question Text
                        Text(
                          "Q${qIndex + 1}. ${question['question']}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Options
                        ...List.generate(options.length, (optIndex) {
                          final option = options[optIndex];

                          Color borderColor = Colors.grey;

                          if (selectedIndex != null) {
                            if (showAllExplanations) {
                              if (optIndex == selectedIndex) {
                                borderColor =
                                    (optIndex == correctIndex)
                                        ? Colors.green
                                        : Colors.red;
                              } else if (optIndex == correctIndex) {
                                borderColor = Colors.green;
                              }
                            } else {
                              if (optIndex == selectedIndex) {
                                borderColor = Colors.grey.shade800;
                              }
                            }
                          }

                          return GestureDetector(
                            onTap: () => selectAnswer(qIndex, optIndex),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "${String.fromCharCode(65 + optIndex)}. ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(child: Text(option)),
                                ],
                              ),
                            ),
                          );
                        }),

                        if (selectedIndex != null && showAllExplanations) ...[
                          const SizedBox(height: 8),

                          GestureDetector(
                            onTap: () => toggleExplanation(qIndex),
                            child: Text(
                              (showExplanation[qIndex] ?? false)
                                  ? "▼ Explanation"
                                  : "▲ Explanation",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),

                          if (showExplanation[qIndex] ?? false)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                question["explanation"],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green.shade900,
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton:
          (_showSubmitButton && selectedAnswers.isNotEmpty)
              ? FloatingActionButton.extended(
                backgroundColor: Colors.lightBlue,
                onPressed: showExplanationsOnly,
                label: const Text("Submit Answers(s)"),
              )
              : null,
    );
  }
}
