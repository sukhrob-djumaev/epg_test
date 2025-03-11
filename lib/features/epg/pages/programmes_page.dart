import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epg_test/features/epg/models/channel.dart';
import 'package:epg_test/features/epg/widgets/day_bar.dart';
import 'package:epg_test/features/epg/widgets/programme_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ProgrammesPage extends HookConsumerWidget {
  final Channel channel;
  const ProgrammesPage({super.key, required this.channel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const initialOffset = 100;

    final barController = usePageController(initialPage: initialOffset, viewportFraction: 0.2);
    final pageController = usePageController(initialPage: initialOffset);
    final activeDayIndex = useState(initialOffset);

    return Scaffold(
      appBar: AppBar(
        title: channel.icon.isNotEmpty ? CachedNetworkImage(width: 50, height: 50, imageUrl: channel.icon) : null,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.open_in_new))],
      ),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: DayBar(
                controller: barController,
                onPageChanged: (value) {
                  activeDayIndex.value = value;

                  pageController.animateToPage(
                    value,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                activeIndex: activeDayIndex.value,
              ),
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  activeDayIndex.value = value;

                  barController.animateToPage(
                    value,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                controller: pageController,
                itemBuilder: (context, index) {
                  final day = DateTime.now().subtract(Duration(days: initialOffset - index));
                  final clearDay = DateTime(day.year, day.month, day.day);
                  return ProgrammeList(channelId: channel.id, day: clearDay);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
