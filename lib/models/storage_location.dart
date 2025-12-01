import 'package:equatable/equatable.dart';

class StorageLocationModel extends Equatable {
  final int? id;
  final String? location;

  const StorageLocationModel({
    this.id,
    this.location,
  });

  @override
  List<Object?> get props => [
        id,
        location,
      ];

  StorageLocationModel copyWith({
    int? id,
    String? location,
  }) {
    return StorageLocationModel(
      id: id ?? this.id,
      location: location ?? this.location,
    );
  }

  factory StorageLocationModel.fromJson(Map<String, dynamic> json) {
    return StorageLocationModel(
      id: json['id'],
      location: json['storage_location'] ?? "",
    );
  }
  static const empty = StorageLocationModel(
    id: 0,
    location: "",
  );

  @override
  String toString() => '{id: $id, location: $location}';
}
