import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/model/customer_review.dart';

class RestaurantReviewWidget extends StatelessWidget {
  final List<CustomerReview> reviews;

  const RestaurantReviewWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      padding: EdgeInsets.symmetric(vertical: 8),
      itemBuilder:
          (context, i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviews[i].name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  reviews[i].date,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(reviews[i].review),
              ],
            ),
          ),
    );
  }
}
