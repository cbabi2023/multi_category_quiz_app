
import 'package:quiz_app/utils/image_constants/image_constants.dart';



class DummyDb {
  static List<Map<String, dynamic>> categoryList = [
    {
      "name": "Sports",
      "questions": 5,
      "image": ImageConstants.basketball,
      "questionsList": [
        {
          "question": "What is the highest score in a basketball game?",
          "options": ["100", "150", "200", "250"],
          "correctIndex": 1,
        },
        {
          "question": "Which player is known as 'King James'?",
          "options": ["Kobe Bryant", "LeBron James", "Michael Jordan", "Kevin Durant"],
          "correctIndex": 1,
        },
        {
          "question": "How many players are on a basketball team?",
          "options": ["5", "6", "7", "8"],
          "correctIndex": 0,
        },
        {
          "question": "What is the diameter of a basketball hoop?",
          "options": ["18 inches", "16 inches", "20 inches", "22 inches"],
          "correctIndex": 0,
        },
        {
          "question": "In which year were the first modern Olympics held?",
          "options": ["1896", "1900", "1924", "1936"],
          "correctIndex": 0,
        },
      ],
    },
    {
      "name": "Chemistry",
      "questions": 5,
      "image": ImageConstants.chemistry,
      "questionsList": [
        {
          "question": "What is the chemical symbol for water?",
          "options": ["H2O", "O2", "CO2", "NaCl"],
          "correctIndex": 0,
        },
        {
          "question": "What is the pH level of pure water?",
          "options": ["7", "0", "14", "10"],
          "correctIndex": 0,
        },
        {
          "question": "What gas do plants absorb from the atmosphere?",
          "options": ["Oxygen", "Carbon Dioxide", "Nitrogen", "Hydrogen"],
          "correctIndex": 1,
        },
        {
          "question": "What is the most abundant gas in the Earth's atmosphere?",
          "options": ["Oxygen", "Nitrogen", "Carbon Dioxide", "Argon"],
          "correctIndex": 1,
        },
        {
          "question": "What is the atomic number of Helium?",
          "options": ["1", "2", "3", "4"],
          "correctIndex": 1,
        },
      ],
    },
    {
      "name": "Math",
      "questions": 5,
      "image": ImageConstants.maths,
      "questionsList": [
        {
          "question": "What is 2 + 2?",
          "options": ["3", "4", "5", "6"],
          "correctIndex": 1,
        },
        {
          "question": "What is the square root of 16?",
          "options": ["2", "3", "4", "5"],
          "correctIndex": 2,
        },
        {
          "question": "What is the value of Pi (π) approximately?",
          "options": ["3.14", "2.14", "3.24", "3.54"],
          "correctIndex": 0,
        },
        {
          "question": "What is 10 - 4?",
          "options": ["4", "6", "5", "7"],
          "correctIndex": 1,
        },
        {
          "question": "What is 5 × 6?",
          "options": ["30", "25", "35", "40"],
          "correctIndex": 0,
        },
      ],
    },
    {
      "name": "History",
      "questions": 5,
      "image": ImageConstants.history,
      "questionsList": [
        {
          "question": "Who was the first president of the USA?",
          "options": ["Abraham Lincoln", "George Washington", "Thomas Jefferson", "John Adams"],
          "correctIndex": 1,
        },
        {
          "question": "In which year did World War II begin?",
          "options": ["1939", "1945", "1914", "1941"],
          "correctIndex": 0,
        },
        {
          "question": "What ancient civilization built the pyramids?",
          "options": ["Romans", "Greeks", "Egyptians", "Aztecs"],
          "correctIndex": 2,
        },
        {
          "question": "Who wrote the Declaration of Independence?",
          "options": ["Benjamin Franklin", "John Adams", "Thomas Jefferson", "George Washington"],
          "correctIndex": 2,
        },
        {
          "question": "Which war was fought between the North and South regions in the USA?",
          "options": ["World War I", "Civil War", "Revolutionary War", "Vietnam War"],
          "correctIndex": 1,
        },
      ],
    },
    {
      "name": "Biological",
      "questions": 5,
      "image": ImageConstants.biology,
      "questionsList": [
        {
          "question": "What is the basic unit of life?",
          "options": ["Atom", "Molecule", "Cell", "Tissue"],
          "correctIndex": 2,
        },
        {
          "question": "What process do plants use to make food?",
          "options": ["Photosynthesis", "Respiration", "Digestion", "Transpiration"],
          "correctIndex": 0,
        },
        {
          "question": "Which organ is responsible for pumping blood?",
          "options": ["Liver", "Heart", "Lungs", "Kidneys"],
          "correctIndex": 1,
        },
        {
          "question": "What is the genetic material in living organisms?",
          "options": ["DNA", "RNA", "Protein", "Carbohydrate"],
          "correctIndex": 0,
        },
        {
          "question": "What do you call an organism that makes its own food?",
          "options": ["Heterotroph", "Autotroph", "Decomposer", "Carnivore"],
          "correctIndex": 1,
        },
      ],
    },
    {
      "name": "Geography",
      "questions": 5,
      "image": ImageConstants.geography,
      "questionsList": [
        {
          "question": "What is the capital of France?",
          "options": ["Berlin", "Madrid", "Paris", "Rome"],
          "correctIndex": 2,
        },
        {
          "question": "Which is the largest ocean?",
          "options": ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean", "Pacific Ocean"],
          "correctIndex": 3,
        },
        {
          "question": "What mountain range separates Europe from Asia?",
          "options": ["Himalayas", "Andes", "Rockies", "Ural"],
          "correctIndex": 3,
        },
        {
          "question": "Which country is known as the Land of the Rising Sun?",
          "options": ["China", "Japan", "Korea", "Thailand"],
          "correctIndex": 1,
        },
        {
          "question": "What is the longest river in the world?",
          "options": ["Amazon", "Nile", "Yangtze", "Mississippi"],
          "correctIndex": 1,
        },
      ],
    },
  ];
}
