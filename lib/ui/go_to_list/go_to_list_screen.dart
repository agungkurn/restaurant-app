import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/go_to_list/go_to_list_marker_provider.dart';
import 'package:flutter_submission_2/provider/go_to_list/go_to_list_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/ui/restaurant_item_widget.dart';

class GoToListScreen extends ConsumerWidget {
  const GoToListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(goToListProvider);
    final listStateNotifier = ref.read(goToListProvider.notifier);
    final markerState = ref.watch(goToListMarkerProvider);
    final markerStateNotifier = ref.read(goToListMarkerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Go To List"),
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
      ),
      body: listState.when(
        data:
            (restaurants) =>
                restaurants.isEmpty
                    ? Center(child: Text("No data added"))
                    : ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder:
                          (context, i) => _ListItem(
                            context,
                            restaurants[i],
                            markerState.toggleMarker,
                            markerState.markedIndices.contains(i),
                            (checked) {
                              checked
                                  ? markerStateNotifier.addIndex(i)
                                  : markerStateNotifier.removeIndex(i);
                            },
                          ),
                    ),
        error: (error, stackTrace) => SizedBox.shrink(),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _ListItem(
    BuildContext context,
    RestaurantListItem value,
    bool showMarker,
    bool checked,
    Function(bool) onCheck,) =>
      RestaurantItemWidgetWithMarker(
        context,
        value,
        showMarker,
        checked,
        onCheck,
            () {
          Navigator.of(
            context,
          ).pushNamed(NavigationRoute.details.routeName, arguments: value);
        },
  );
}
