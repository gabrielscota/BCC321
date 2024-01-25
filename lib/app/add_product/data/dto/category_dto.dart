import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class CategoryDto {
  final String id;
  final String name;
  final String description;

  CategoryDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryDto.fromMap(Map<String, dynamic> map) {
    try {
      return CategoryDto(
        id: map['id'].toString(),
        name: map['name'] as String,
        description: map['description'] != null ? map['description'] as String : '',
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing category from map');
    }
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      description: description,
    );
  }
}
