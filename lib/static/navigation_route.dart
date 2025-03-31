enum NavigationRoute {
  home("/"),
  details("/details"),
  goToList("/go-to"),
  settings("/settings");

  const NavigationRoute(this.routeName);

  final String routeName;

  static NavigationRoute find(String? routeName) =>
      NavigationRoute.values.firstWhere(
        (element) => element.routeName == routeName,
        orElse: () => NavigationRoute.home,
      );
}
