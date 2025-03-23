import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final int id;
  final int? carId;
  final String? content;

  Note({
    required this.id,
    this.carId,
    this.content,
  });

  Map<String, dynamic> toMap() => _$NoteToJson(this);

  factory Note.fromMap(Map<String, dynamic> json) => _$NoteFromJson(json);

  String getTableName() => 'notes';
}
