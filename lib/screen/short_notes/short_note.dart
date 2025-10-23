import 'package:flutter/material.dart';

class ShortNotesPage extends StatefulWidget {
  const ShortNotesPage({Key? key}) : super(key: key);

  @override
  State<ShortNotesPage> createState() => _ShortNotesPageState();
}

class _ShortNotesPageState extends State<ShortNotesPage> {
  int _selectedChapterIndex = 0;

  final List<String> chapters = [
    'CH 1',
    'CH 2',
    'CH 3',
    'CH 4',
    'CH 5',
  ];

  final Map<String, List<TextSpan>> chapterContents = {
    'CH 1': [
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
        text: 'There are two types of cells: prokaryotic and eukaryotic. ',
      ),
      const TextSpan(
        text:
            'Prokaryotic cells (like bacteria) do not have a true nucleus, while eukaryotic cells (found in plants, animals, fungi, and protists) '
            'have a well-defined nucleus and membrane-bound organelles.\n\n',
      ),
      const TextSpan(
        text: 'Cell Organelles and Their Functions:\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(children: [
        const TextSpan(text: '- '),
        const TextSpan(
          text: 'Nucleus: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
            text: 'Contains genetic material (DNA) and controls the cell\'s activities.\n'),
        const TextSpan(text: '- '),
        const TextSpan(
          text: 'Mitochondria: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
            text:
                'Known as the powerhouse of the cell, they produce energy (ATP) via cellular respiration.\n'),
        const TextSpan(text: '- '),
        const TextSpan(
          text: 'Endoplasmic Reticulum (ER): ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
            text:
                'Rough ER is involved in protein synthesis, and Smooth ER is involved in lipid synthesis and detoxification.\n'),
        const TextSpan(text: '- '),
        const TextSpan(
          text: 'Golgi Apparatus: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
            text:
                'Modifies, sorts, and packages proteins and lipids for storage or transport out of the cell.\n'),
        const TextSpan(text: '- '),
        const TextSpan(
          text: 'Lysosomes: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
            text:
                'Contain digestive enzymes that help break down waste materials and cellular debris.\n'),
        const TextSpan(text: '- '),
        const TextSpan(
          text: 'Chloroplasts (in plant cells): ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
            text:
                'Site of photosynthesis, contain chlorophyll that captures light energy.\n'),
      ]),
    ],
    'CH 2': [
      const TextSpan(
        text: 'Nutrition in Plants\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Plants prepare their own food by the process of photosynthesis. This process mainly takes place in the leaves of the plant. '
            'It requires sunlight, carbon dioxide, water, and chlorophyll. The food prepared is stored in the form of glucose or starch.\n\n',
      ),
      const TextSpan(
        text:
            'There are also some non-green plants and insectivorous plants that get their nutrition in other ways.\n',
      ),
    ],
    'CH 3': [
      const TextSpan(
        text: 'Transportation in Animals and Plants\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Transportation is the process of movement of water, minerals, and food to all parts of the plant body. In animals, it refers to the circulation of blood.\n\n',
      ),
      const TextSpan(
        text:
            'In humans, the circulatory system includes the heart, blood, and blood vessels. In plants, xylem transports water and minerals, while phloem transports food.\n',
      ),
    ],
    'CH 4': [
      const TextSpan(
        text: 'Respiration in Organisms\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Respiration is the biochemical process in which food is broken down to release energy. '
            'It occurs in all living organisms and can be aerobic (with oxygen) or anaerobic (without oxygen).\n\n',
      ),
      const TextSpan(
        text:
            'The energy released is stored in the form of ATP (Adenosine Triphosphate), which is then used for various activities of the body.\n',
      ),
    ],
    'CH 5': [
      const TextSpan(
        text: 'Reproduction in Plants\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Reproduction is the biological process by which new individual organisms are produced. In plants, reproduction can be sexual or asexual.\n\n',
      ),
      const TextSpan(
        text:
            'Sexual reproduction involves the fusion of male and female gametes. Asexual reproduction includes methods like budding, fragmentation, and vegetative propagation.\n',
      ),
    ],
  };

  // Removed @override initState() method

  List<TextSpan> _getSelectedChapterContent() {
    if (_selectedChapterIndex < 0 || _selectedChapterIndex >= chapters.length) return [];

    final selectedChapter = chapters[_selectedChapterIndex];

    if (!chapterContents.containsKey(selectedChapter)) return [];

    return chapterContents[selectedChapter]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Short Notes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject Box
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Biology',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 41, 144, 72),
                  ),
                ),
              ),
            ),
          ),

          // First Divider
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),

          // Chapters Row
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedChapterIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedChapterIndex = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(right: 12, top: 8),
                    // Decoration fix from previous step is still correct
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? Colors.lightGreen : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      chapters[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.grey[700],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Second Divider
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),

          // Main content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  // This is the call that required the fields to be initialized immediately
                  children: _getSelectedChapterContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}