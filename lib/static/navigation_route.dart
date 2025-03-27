enum NavigationRoute {
  home("/"),
  details("/details"),
  goToList("/go-to");

  const NavigationRoute(this.routeName);

  final String routeName;
}
