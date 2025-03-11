// import 'dart:convert';
// import 'package:xml2json/xml2json.dart';

// const kQuoteReplacer = "¿*¿*¿*¿*";

// dynamic decodeXmlResponseIntoJson(String data) {
//   String cleanDataString = data.replaceAll("&quot;", kQuoteReplacer);
//   final Xml2Json transformer = Xml2Json();
//   transformer.parse(cleanDataString);
//   final json = transformer.toOpenRally();
//   return jsonDecode(json);
// }

/// Returns start and end time of the selected day in EPG format (YYYYMMDDHHMMSS)
Map<String, String> getDayTimeBounds(DateTime day) {
  final startOfDay = DateTime(day.year, day.month, day.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));

  return {
    'start':
        '${startOfDay.year}${startOfDay.month.toString().padLeft(2, '0')}${startOfDay.day.toString().padLeft(2, '0')}000000',
    'end':
        '${endOfDay.year}${endOfDay.month.toString().padLeft(2, '0')}${endOfDay.day.toString().padLeft(2, '0')}000000',
  };
}

/// Converts EPG timestamp to Dart DateTime
DateTime parseEPGDateTime(String epgTimestamp) {
  // Format: YYYYMMDDHHMMSS [+/-Timezone]
  final dateStr = epgTimestamp.substring(0, 8); // YYYYMMDD
  final timeStr = epgTimestamp.substring(8, 14); // HHMMSS
  return DateTime.parse('${dateStr}T$timeStr');
}
