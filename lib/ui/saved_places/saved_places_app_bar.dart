import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/provider/saved_places/saved_places_marker_provider.dart';
import 'package:flutter_submission_2/provider/saved_places/saved_places_provider.dart';

AppBar SavedPlacesAppBar(BuildContext context, WidgetRef ref) {
  final listStateNotifier = ref.read(savedPlacesProvider.notifier);
  final markerState = ref.watch(savedPlacesMarkerProvider);
  final markerStateNotifier = ref.read(savedPlacesMarkerProvider.notifier);

  return AppBar(
    leading:
        markerState.toggleMarker
            ? IconButton(
              onPressed: () {
                markerStateNotifier.toggleMarker();
              },
              icon: Icon(Icons.close),
            )
            : null,
    title:
        markerState.toggleMarker
            ? markerState.markedIndices.length > 0
                ? Text("${markerState.markedIndices.length}")
                : SizedBox.shrink()
            : Text("Saved Places"),
    actions: [
      markerState.markedIndices.isNotEmpty
          ? IconButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text("Delete Confirmation"),
                      content: Text(
                        "Delete ${markerState.markedIndices.length} item(s)?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text("Delete"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
              );

              if (confirmed == true) {
                await listStateNotifier.removeFromListByIndices(
                  markerState.markedIndices,
                );
                final snackBar = SnackBar(
                  content: Text(
                    "${markerState.markedIndices.length} item(s) deleted",
                  ),
                );
                markerStateNotifier.clearMarkedIndices();
                markerStateNotifier.toggleMarker();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            icon: Icon(Icons.delete),
          )
          : SizedBox.shrink(),
      markerState.toggleMarker
          ? IconButton.filledTonal(
            onPressed: () {
              markerStateNotifier.toggleMarker();
            },
            icon: Icon(Icons.checklist),
          )
          : IconButton(
            onPressed: () {
              markerStateNotifier.toggleMarker();
            },
            icon: Icon(Icons.checklist),
          ),
    ],
  );
}
