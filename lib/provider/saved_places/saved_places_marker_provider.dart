import 'package:flutter_submission_2/provider/saved_places/saved_places_marker_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_places_marker_provider.g.dart';

@riverpod
class SavedPlacesMarker extends _$SavedPlacesMarker {
  @override
  SavedPlacesMarkerState build() => const SavedPlacesMarkerState();

  void addIndex(int index) {
    final modified = [...state.markedIndices, index];
    state = state.copyWith(markedIndices: modified);
  }

  void removeIndex(int index) {
    final modified =
        state.markedIndices.where((element) => element != index).toList();
    state = state.copyWith(markedIndices: modified);
  }

  void clearMarkedIndices() {
    state = state.copyWith(markedIndices: []);
  }

  void toggleMarker() {
    final shouldShow = !state.toggleMarker == true;
    if (shouldShow) {
      state = state.copyWith(toggleMarker: shouldShow);
    } else {
      state = state.copyWith(toggleMarker: shouldShow, markedIndices: []);
    }
  }
}
