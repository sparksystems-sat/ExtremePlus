import 'package:exam_practice_app/features/game/models/quiz_model.dart';

class QuizData {
  static List<QuizSubject> getQuizSubjects() {
    return [
      QuizSubject(
        id: 1,
        name: "Chemistry",
        description: "Every great discovery begins with a question.",
        questions: [
          QuizQuestion(
            id: 1,
            question: "The chemical symbol for water is __",
            options: ["O2", "H2O", "CO2", "HO"],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 2,
            question:
                "The atomic number represents the number of __ in an atom",
            options: ["neutrons", "electrons", "protons", "molecules"],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 3,
            question:
                "Which state of matter has a fixed volume but no fixed shape?",
            options: ["Solid", "Gas", "Liquid", "Plasma"],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 4,
            question: "A substance with a pH less than 7 is called __",
            options: ["Base", "Salt", "Acid", "Neutral"],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 5,
            question:
                "The process of a solid changing directly into a gas is called __",
            options: ["Melting", "Evaporation", "Condensation", "Sublimation"],
            correctAnswerIndex: 3,
          ),
        ],
      ),
      QuizSubject(
        id: 2,
        name: "Mathematics",
        description: "Challenge your mathematical skills.",
        questions: [
          QuizQuestion(
            id: 1,
            question: "What is 15 + 27?",
            options: ["40", "42", "43", "45"],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 2,
            question: "What is 8 × 7?",
            options: ["54", "56", "58", "60"],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 3,
            question: "What is the square root of 144?",
            options: ["10", "11", "12", "13"],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 4,
            question: "What is 100 ÷ 4?",
            options: ["20", "25", "30", "35"],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 5,
            question: "What is 2³?",
            options: ["6", "8", "9", "12"],
            correctAnswerIndex: 1,
          ),
        ],
      ),
      QuizSubject(
        id: 3,
        name: "Biology",
        description: "Test your knowledge of life sciences.",
        questions: [
          QuizQuestion(
            id: 1,
            question: "What is the powerhouse of the cell?",
            options: ["Nucleus", "Mitochondria", "Ribosome", "Chloroplast"],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 2,
            question: "What is the process by which plants make food?",
            options: [
              "Respiration",
              "Digestion",
              "Photosynthesis",
              "Fermentation",
            ],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 3,
            question: "What is DNA?",
            options: [
              "Deoxyribonucleic acid",
              "Dinitrogen acid",
              "Dextrose acid",
              "Dioxide acid",
            ],
            correctAnswerIndex: 0,
          ),
          QuizQuestion(
            id: 4,
            question: "How many chambers does the human heart have?",
            options: ["2", "3", "4", "5"],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 5,
            question: "What is the largest organ in the human body?",
            options: ["Heart", "Brain", "Liver", "Skin"],
            correctAnswerIndex: 3,
          ),
        ],
      ),
      QuizSubject(
        id: 4,
        name: "Physics",
        description: "Explore the laws of nature.",
        questions: [
          QuizQuestion(
            id: 1,
            question: "What is the speed of light?",
            options: [
              "300,000 km/s",
              "150,000 km/s",
              "450,000 km/s",
              "600,000 km/s",
            ],
            correctAnswerIndex: 0,
          ),
          QuizQuestion(
            id: 2,
            question: "What is Newton's first law?",
            options: ["F = ma", "Law of inertia", "Action-reaction", "Gravity"],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 3,
            question: "What is the unit of force?",
            options: ["Joule", "Watt", "Newton", "Pascal"],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 4,
            question: "What is the acceleration due to gravity on Earth?",
            options: ["8.8 m/s²", "9.8 m/s²", "10.8 m/s²", "11.8 m/s²"],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 5,
            question: "What type of energy is stored in a battery?",
            options: ["Kinetic", "Potential", "Chemical", "Thermal"],
            correctAnswerIndex: 2,
          ),
        ],
      ),
    ];
  }
}
