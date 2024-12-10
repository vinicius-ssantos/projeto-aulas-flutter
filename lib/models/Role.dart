class Role {
  final int id;
  final String name;

  Role(this.id, this.name);

  factory Role.fromObject(Map<String, dynamic> obj) {
    return Role(
      obj['id'],
      obj['name'],
    );
  }

  Map<String, dynamic> toObject() {
    return {
      'id': id,
      'name': name,
    };
  }
}
