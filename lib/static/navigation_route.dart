enum NavigationRoute {
  main("/"),
  details("/details");

  const NavigationRoute(this.routeName);

  final String routeName;

  static NavigationRoute find(String? routeName) =>
      NavigationRoute.values.firstWhere(
        (element) => element.routeName == routeName,
        orElse: () => NavigationRoute.main,
      );
}
