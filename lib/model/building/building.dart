import 'package:freezed_annotation/freezed_annotation.dart';

part 'building.freezed.dart';
part 'building.g.dart';

@freezed
class Building with _$Building {
  factory Building({
    @Default('') dynamic BuildingName,
    @Default('') dynamic BuildingID,
    @Default('') dynamic RegionID,
    @Default('') dynamic IOTBuilding,
    @Default('') dynamic ResidenceHall,
    @Default('') dynamic Type,
  }) = _Building;

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
}
