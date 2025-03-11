import 'package:epg_test/features/epg/models/programme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgrammeItem extends StatelessWidget {
  final Programme item;
  const ProgrammeItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final timeOfProgrammeFormatter = DateFormat.Hm();
    final isActive = item.start.isBefore(DateTime.now()) && item.end.isAfter(DateTime.now());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isActive ? BorderSide(color: Colors.white) : BorderSide.none,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(3),
            width: 3,
            decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(4)),
            height: 50,
          ),
          Expanded(
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(timeOfProgrammeFormatter.format(item.start), style: Theme.of(context).textTheme.titleMedium),
                  Text(timeOfProgrammeFormatter.format(item.end), style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              title: Text(item.title, maxLines: 1),
              subtitle: Text(item.desc, maxLines: 2),
            ),
          ),
        ],
      ),
    );
    // return Card(
    //   child: Row(
    //     children: [
    //       Container(margin: EdgeInsets.all(3), width: 3, color: Colors.lightBlue, height: 100),

    //       Column(
    //         children: [
    //           Text(timeOfProgrammeFormatter.format(item.start)),
    //           Text(timeOfProgrammeFormatter.format(item.end)),
    //         ],
    //       ),
    //       Expanded(child: Text(item.title)),
    //     ],
    //   ),
    // );
  }
}
