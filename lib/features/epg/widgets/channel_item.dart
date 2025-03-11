import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epg_test/core/router/app_router.gr.dart';
import 'package:epg_test/features/epg/models/channel.dart';
import 'package:flutter/material.dart';

class ChannelItem extends StatelessWidget {
  final Channel item;
  const ChannelItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.pushRoute(ProgrammesRoute(channel: item)),
        borderRadius: BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Spacer(),

              Text(
                item.displayName,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              Spacer(),

              if (item.icon.isNotEmpty)
                Expanded(flex: 4, child: CachedNetworkImage(imageUrl: item.icon, fit: BoxFit.contain)),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
