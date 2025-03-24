import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/model/restaurant_details.dart';
import 'package:flutter_submission_2/provider/restaurant_details_provider.dart';
import 'package:flutter_submission_2/static/ui_state.dart';
import 'package:flutter_submission_2/ui/details/description_widget.dart';
import 'package:flutter_submission_2/ui/details/menu_widget.dart';
import 'package:flutter_submission_2/ui/details/review_widget.dart';
import 'package:flutter_submission_2/ui/details/tab_bar_delegate.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantDetailsProvider>().fetch(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailsProvider>(
        builder:
            (context, value, child) => switch (value.uiState) {
              Loading() => Center(child: CircularProgressIndicator()),
              Success<RestaurantDetails>(data: var details) =>
                DefaultTabController(
                  length: 3,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (context, isScrolled) => [
                          DetailsAppBar(details, context),
                          DetailsBasicInfo(details, context),
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
                        RestaurantReviewWidget(
                          reviews: details.customerReviews,
                        ),
                      ],
                    ),
                  ),
                ),
              Error(errorMessage: var msg) => Center(child: Text(msg)),
              _ => SizedBox(),
            },
      ),
    );
  }

  Widget DetailsBasicInfo(RestaurantDetails details, BuildContext context) {
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
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black54),
                    ),
                    Text(
                      details.city,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Text(
                    details.rating.toString(),
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: Colors.black54),
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

  Widget DetailsAppBar(RestaurantDetails details, BuildContext context) {
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
    );
  }
}
