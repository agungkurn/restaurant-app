import 'package:flutter/material.dart';
import 'package:flutter_submission_2/provider/go_to_list_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/ui/restaurant_item_widget.dart';
import 'package:provider/provider.dart';

class GoToListScreen extends StatelessWidget {
  const GoToListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Go To List")),
    body: FutureBuilder(
      future: context.read<GoToListProvider>().getGoToList(),
      builder:
          (context, snapshot) => Consumer<GoToListProvider>(
            builder:
                (context, value, child) =>
                    value.restaurants.isEmpty
                        ? Center(child: Text("No data added"))
                        : ListView.builder(
                          itemCount: value.restaurants.length,
                          itemBuilder:
                              (context, i) => _ListItem(context, i, value),
                        ),
          ),
    ),
  );

  Row _ListItem(BuildContext context, int i, GoToListProvider value) => Row(
    children: [
      Expanded(
        child: RestaurantItemWidget(context, value.restaurants[i], () {
          Navigator.of(context).pushNamed(
            NavigationRoute.details.routeName,
            arguments: value.restaurants[i],
          );
        }),
      ),
    ],
  );
}
