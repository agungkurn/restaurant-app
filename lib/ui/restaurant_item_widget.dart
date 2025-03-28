import 'package:flutter/material.dart';

import '../data/model/restaurant_list_item.dart';

Widget _MainContent(BuildContext context, RestaurantListItem item) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      width: 120,
      height: 80,
      margin: EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(item.picture, fit: BoxFit.cover),
      ),
    ),
    Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(Icons.location_pin, color: Colors.black54),
              Text(
                item.city,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange),
              Text(
                item.rating.toString(),
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);

Widget RestaurantItemWidget(
  BuildContext context,
  RestaurantListItem item,
  Function() onClick,
) => InkWell(
  onTap: onClick,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: _MainContent(context, item),
  ),
);

Widget RestaurantItemWidgetWithMarker(
  BuildContext context,
  RestaurantListItem item,
  bool showMarker,
  bool checked,
  Function(bool) onCheck,
  Function() onClick,
) => InkWell(
  onTap: () {
    showMarker ? onCheck(!checked) : onClick();
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      showMarker
          ? Checkbox(
            value: checked,
            onChanged: (checked) => onCheck(checked == true),
          )
          : SizedBox.shrink(),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: _MainContent(context, item),
        ),
      ),
    ],
  ),
);
