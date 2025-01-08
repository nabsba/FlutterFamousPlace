class Selection {
  final String name;
  final String id;

  Selection({required this.name, required this.id});

  factory Selection.fromMap(Map<String, dynamic> map) {
    return Selection(
      name: map['name'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }
}

class PreselectionNameData {
  final List<Selection> selections;

  PreselectionNameData({required this.selections});

  factory PreselectionNameData.fromMap(Map<String, dynamic> map) {
    return PreselectionNameData(
      selections: List<Selection>.from(
        map['selections']?.map((selection) => Selection.fromMap(selection)) ??
            [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selections': selections.map((selection) => selection.toMap()).toList(),
    };
  }
}
