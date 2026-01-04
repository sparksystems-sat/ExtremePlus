class RandomLesson {
  const RandomLesson({
    required this.title,
    required this.subject,
    required this.body,
  });

  final String title;
  final String subject;
  final String body;
}

const List<RandomLesson> lessons = <RandomLesson>[
  RandomLesson(
    title: 'Mitochondria',
    subject: 'Biology',
    body:
        'Mitochondria are known as the powerhouses of the cell. They are responsible for producing energy through the process of oxidative phosphorylation.\n\nMitochondria have their own DNA and are thought to have originated from symbiotic bacteria.',
  ),
  RandomLesson(
    title: 'Covalent Bonds',
    subject: 'Chemistry',
    body:
        'Covalent bonds are chemical bonds formed by the sharing of electron pairs between atoms.\n\nThey typically occur between non‑metal elements.\n\nSingle bond: sharing one pair of electrons (e.g., H–H).\nDouble bond: sharing two pairs of electrons.',
  ),
  RandomLesson(
    title: 'Trigonometry Basics',
    subject: 'Math',
    body:
        'SOH‑CAH‑TOA helps remember the primary trig ratios: sin, cos, tan.\n\nA key identity is sin²(x) + cos²(x) = 1.\n\nUse the unit circle for common angles to quickly recall values.',
  ),
  RandomLesson(
    title: 'Newton\'s Second Law',
    subject: 'Physics',
    body:
        'Newton\'s second law states that the net force on an object equals mass times acceleration: F = m·a.\n\nIf mass is constant, increasing net force increases acceleration proportionally.',
  ),
];
