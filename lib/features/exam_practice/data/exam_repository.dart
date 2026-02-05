import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/exam_question.dart';
import '../models/exam_subject.dart';
import '../models/exam_grade.dart';

class ExamRepository {
  static List<ExamGrade> getGrades() {
    return [
      ExamGrade(
        id: 'grade_9',
        label: 'Grade 9',
        icon: Icons.stairs,
        color: Colors.green,
      ),
      ExamGrade(
        id: 'grade_10',
        label: 'Grade 10',
        icon: Icons.lightbulb,
        color: Colors.yellow[700]!,
      ),
      ExamGrade(
        id: 'grade_11',
        label: 'Grade 11',
        icon: Icons.local_fire_department,
        color: Colors.red,
      ),
      ExamGrade(
        id: 'grade_12',
        label: 'Grade 12',
        icon: FontAwesomeIcons.bullseye,
        color: Colors.blue,
      ),
    ];
  }

  static List<ExamSubject> getSubjects() {
    return [
      ExamSubject(
        id: 'mathematics',
        name: 'Mathematics',
        icon: Icons.calculate,
        color: Colors.orange,
        progress: 40,
      ),
      ExamSubject(
        id: 'biology',
        name: 'Biology',
        icon: Icons.biotech,
        color: Colors.green,
        progress: 60,
      ),
      ExamSubject(
        id: 'physics',
        name: 'Physics',
        icon: FontAwesomeIcons.bolt,
        color: Colors.blue,
        progress: 30,
      ),
      ExamSubject(
        id: 'chemistry',
        name: 'Chemistry',
        icon: FontAwesomeIcons.flask,
        color: Colors.purple,
        progress: 50,
      ),
    ];
  }

  static List<ExamQuestion> getQuestionsBySubject(String subjectId) {
    final allQuestions = {
      'mathematics': _getMathQuestions(),
      'biology': _getBiologyQuestions(),
      'physics': _getPhysicsQuestions(),
      'chemistry': _getChemistryQuestions(),
    };

    return allQuestions[subjectId] ?? [];
  }

  static List<ExamQuestion> _getMathQuestions() {
    return [
      ExamQuestion(
        id: 'math_1',
        question: 'What is the capital of France?',
        options: ['Berlin', 'Paris', 'Madrid', 'Rome'],
        correctAnswerIndex: 1,
        explanation:
            'The capital of France is Paris. It is known for its art, gastronomy, and culture.',
      ),
      ExamQuestion(
        id: 'math_2',
        question: 'What is the largest planet in our solar system?',
        options: ['Earth', 'Venus', 'Mars', 'Jupiter'],
        correctAnswerIndex: 3,
        explanation:
            'Jupiter is the largest planet in our solar system, known for its Great Red Spot.',
      ),
      ExamQuestion(
        id: 'math_3',
        question: 'Choose the correct sentence:',
        options: [
          'She don\'t like apples.',
          'She doesn\'t like apples.',
          'She didn\'t likes apples.',
          'She doesn\'t likes apples.',
        ],
        correctAnswerIndex: 1,
        explanation:
            'Correct: \'She doesn\'t like apples.\' because \'doesn\'t\' is used with base verb.',
      ),
      ExamQuestion(
        id: 'math_4',
        question: 'What is the synonym of \'happy\'?',
        options: ['Sad', 'Joyful', 'Angry', 'Tired'],
        correctAnswerIndex: 1,
        explanation: '\'Joyful\' is the closest synonym of \'happy\'.',
      ),
      ExamQuestion(
        id: 'math_5',
        question: 'Which word is a noun?',
        options: ['Run', 'Quickly', 'Book', 'Blue'],
        correctAnswerIndex: 2,
        explanation:
            '\'Book\' is a noun. The others are verb, adverb, and adjective.',
      ),
    ];
  }

  static List<ExamQuestion> _getBiologyQuestions() {
    return [
      ExamQuestion(
        id: 'bio_1',
        question: 'What is the powerhouse of the cell?',
        options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Chloroplast'],
        correctAnswerIndex: 1,
        explanation:
            'Mitochondria are known as the powerhouse of the cell because they produce ATP.',
      ),
      ExamQuestion(
        id: 'bio_2',
        question: 'What is photosynthesis?',
        options: [
          'Process of breathing',
          'Process of making food using sunlight',
          'Process of cell division',
          'Process of digestion',
        ],
        correctAnswerIndex: 1,
        explanation:
            'Photosynthesis is the process by which plants make food using sunlight, water, and CO2.',
      ),
      ExamQuestion(
        id: 'bio_3',
        question: 'How many chambers does the human heart have?',
        options: ['2', '3', '4', '5'],
        correctAnswerIndex: 2,
        explanation:
            'The human heart has 4 chambers: two atria and two ventricles.',
      ),
    ];
  }

  static List<ExamQuestion> _getPhysicsQuestions() {
    return [
      ExamQuestion(
        id: 'phy_1',
        question: 'What is the speed of light?',
        options: [
          '300,000 km/s',
          '150,000 km/s',
          '450,000 km/s',
          '600,000 km/s',
        ],
        correctAnswerIndex: 0,
        explanation:
            'The speed of light in vacuum is approximately 300,000 km/s or 3×10⁸ m/s.',
      ),
      ExamQuestion(
        id: 'phy_2',
        question: 'What is Newton\'s first law?',
        options: ['F = ma', 'Law of inertia', 'Action-reaction', 'Gravity'],
        correctAnswerIndex: 1,
        explanation:
            'Newton\'s first law is the law of inertia: an object at rest stays at rest unless acted upon by a force.',
      ),
      ExamQuestion(
        id: 'phy_3',
        question: 'What is the unit of force?',
        options: ['Joule', 'Watt', 'Newton', 'Pascal'],
        correctAnswerIndex: 2,
        explanation:
            'The SI unit of force is Newton (N), named after Sir Isaac Newton.',
      ),
    ];
  }

  static List<ExamQuestion> _getChemistryQuestions() {
    return [
      ExamQuestion(
        id: 'chem_1',
        question: 'What is the chemical symbol for water?',
        options: ['H2O', 'CO2', 'O2', 'H2'],
        correctAnswerIndex: 0,
        explanation:
            'Water is H2O, consisting of two hydrogen atoms and one oxygen atom.',
      ),
      ExamQuestion(
        id: 'chem_2',
        question: 'What is the pH of a neutral solution?',
        options: ['0', '7', '14', '10'],
        correctAnswerIndex: 1,
        explanation:
            'A neutral solution has a pH of 7. Below 7 is acidic, above 7 is basic.',
      ),
      ExamQuestion(
        id: 'chem_3',
        question: 'What is the most abundant gas in Earth\'s atmosphere?',
        options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
        correctAnswerIndex: 1,
        explanation: 'Nitrogen makes up about 78% of Earth\'s atmosphere.',
      ),
    ];
  }
}
