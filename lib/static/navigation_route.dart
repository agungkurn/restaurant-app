enum NavigationRoute {
  home("/"),
  details("/details");

  const NavigationRoute(this.deeplink);

  final String deeplink;
}
