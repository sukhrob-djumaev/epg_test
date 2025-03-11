import 'package:auto_route/auto_route.dart';
import 'package:epg_test/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: ChannelsRoute.page),
    AutoRoute(page: ProgrammesRoute.page),
  ];
}
