import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_places_marker_state.freezed.dart';

@freezed
abstract class SavedPlacesMarkerState with _$SavedPlacesMarkerState {
  const factory SavedPlacesMarkerState({
    @Default([]) List<int> markedIndices,
    @Default(false) bool toggleMarker,
  }) = _SavedPlacesMarkerState;
}
