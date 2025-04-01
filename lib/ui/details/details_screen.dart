import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_details.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/details/restaurant_details_provider.dart';
import 'package:flutter_submission_2/provider/saved_places/is_in_list_provider.dart';
import 'package:flutter_submission_2/provider/saved_places/saved_places_provider.dart';
import 'package:flutter_submission_2/ui/details/description_widget.dart';
import 'package:flutter_submission_2/ui/details/menu_widget.dart';
import 'package:flutter_submission_2/ui/details/review_widget.dart';
import 'package:flutter_submission_2/ui/details/tab_bar_delegate.dart';

class DetailsScreen extends ConsumerWidget {
  final RestaurantListItem restaurantListItem;

  const DetailsScreen({super.key, required this.restaurantListItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(
      fetchRestaurantDetailsProvider(restaurantListItem.id),
    );

    return PopScope(
      onPopInvokedWithResult: (_, _) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Scaffold(
        body: detailsState.when(
          data:
              (details) => DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (context, isScrolled) => [
                        DetailsAppBar(context, ref, details),
                        DetailsBasicInfo(context, details),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: TabBarDelegate(
                            TabBar(
                              tabs: [
                                Tab(text: "Description"),
                                Tab(text: "Menu"),
                                Tab(text: "Reviews"),
                              ],
                            ),
                          ),
                        ),
                      ],
                  body: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: RestaurantDescriptionWidget(
                          description: details.description,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: RestaurantMenuWidget(
                          restaurantMenu: details.menus,
                        ),
                      ),
                      RestaurantReviewWidget(reviews: details.customerReviews),
                    ],
                  ),
                ),
              ),
          error: (error, stackTrace) {
            print(stackTrace);
            return Center(child: Text(error.toString()));
          },
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget DetailsAppBar(
    BuildContext context,
    WidgetRef ref,
    RestaurantDetails details,
  ) {
    final goToListState = ref.read(savedPlacesProvider.notifier);
    final isInListState = ref.watch(isInSavedPlacesProvider(details.id));

    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(details.picture, fit: BoxFit.cover),
      ),
      leading: IconButton.filledTonal(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        isInListState.when(
          data:
              (isInList) => IconButton.filledTonal(
                onPressed: () {
                  isInList
                      ? goToListState.removeFromList(details.id)
                      : goToListState.addToList(restaurantListItem);

                  final snackbar = SnackBar(
                    content:
                        isInList
                            ? Text("Removed from \"Saved Places\"")
                            : Text("Added to \"Saved Places\""),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackbar);

                  ref.invalidate(isInSavedPlacesProvider);
                },
                icon: Icon(
                  isInList ? Icons.add_location : Icons.add_location_outlined,
                ),
              ),
          error: (_, _) => SizedBox.shrink(),
          loading: () => SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget DetailsBasicInfo(BuildContext context, RestaurantDetails details) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList.list(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      details.address,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Text(
                      details.city,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Text(
                    details.rating.toString(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children:
                details.categories
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        child: Text(
                          e.name,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
