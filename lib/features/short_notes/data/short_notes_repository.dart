import 'package:flutter/material.dart';

class ShortNotesRepository {
  static Map<String, List<TextSpan>> getChapterContents() {
    return {
      'Ch 1': [
        const TextSpan(
          text: 'Cell: The Basic Unit of Life\n\n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text:
              'All living organisms are made up of cells. The cell is the structural and functional unit of life. '
              'Cells can exist as independent units of life (as in unicellular organisms) or may form tissues and organs in multicellular organisms.\n\n',
        ),
        const TextSpan(
          text: 'Prokaryotic vs. Eukaryotic Cells\n\n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text:
              'Prokaryotic cells lack a membrane-bound nucleus and organelles, while eukaryotic cells have both. '
              'Examples of prokaryotes include bacteria and archaea, while plants, animals, fungi, and protists are eukaryotes.\n\n',
        ),
      ],
      'Ch 2': [
        const TextSpan(
          text: 'Newton\'s First Law\n\n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text:
              'An object in motion stays in motion unless acted upon by a force.\n\n'
              'An object at rest stays at rest unless acted upon by a force.\n\n',
        ),
      ],
      'Ch 3': [
        const TextSpan(
          text: 'Photosynthesis\n\n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text:
              'Photosynthesis is the process by which green plants and some other organisms use sunlight to synthesize nutrients from carbon dioxide and water. '
              'Photosynthesis in plants generally involves the green pigment chlorophyll and generates oxygen as a by-product.\n\n',
        ),
      ],
      'Ch 4': [
        const TextSpan(
          text: 'Chemical Bonding\n\n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text:
              'Chemical bonds are forces that hold atoms together in molecules. The main types are ionic bonds, covalent bonds, and metallic bonds.\n\n',
        ),
      ],
      'Ch 5': [
        const TextSpan(
          text: 'Reproduction\n\n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text:
              'Sexual reproduction involves the fusion of male and female gametes. Asexual reproduction includes methods like budding, fragmentation, and vegetative propagation.\n',
        ),
      ],
    };
  }

  static List<String> getChapters() {
    return ['Ch 1', 'Ch 2', 'Ch 3', 'Ch 4', 'Ch 5'];
  }
}
