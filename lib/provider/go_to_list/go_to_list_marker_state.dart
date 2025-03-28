import 'package:freezed_annotation/freezed_annotation.dart';

part 'go_to_list_marker_state.freezed.dart';

@freezed
abstract class GoToListMarkerState with _$GoToListMarkerState {
  const factory GoToListMarkerState({
    @Default([]) List<int> markedIndices,
    @Default(false) bool toggleMarker,
  }) = _GoToListMarkerState;
}
