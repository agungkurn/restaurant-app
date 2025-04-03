import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/saved_places/saved_places_marker_provider.dart';
import 'package:flutter_submission_2/provider/saved_places/saved_places_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/ui/restaurant_item_widget.dart';

class SavedPlacesScreen extends ConsumerWidget {
  const SavedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(savedPlacesProvider);
    final markerState = ref.watch(savedPlacesMarkerProvider);
    final markerStateNotifier = ref.read(savedPlacesMarkerProvider.notifier);

    return listState.when(
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
    );
  }

  Widget _ListItem(
    BuildContext context,
    RestaurantListItem value,
    bool showMarker,
    bool checked,
    Function(bool) onCheck,
  ) => RestaurantItemWidgetWithMarker(
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
