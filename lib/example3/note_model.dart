class Note {
  final String title;

  const Note({
    required this.title,
  });

  @override
  String toString() => 'Note(title: $title)';
}

final mockNotes = Iterable.generate(3, (i) => Note(title: 'Note $i')).toList();
