import 'package:intl/intl.dart';

class MyFunction {
  static String priceFormat(num data) {
    int price = doubleInt(data.toDouble());
    String result = '';
    int count = 0;

    if (price == 0) {
      return '0';
    } else {
      for (int i = price.toString().length - 1; i >= 0; i--) {
        if (count == 3) {
          result = '${price.toString()[i]},$result';
          count = 0;
        } else {
          result = price.toString()[i] + result;
        }
        count++;
      }
      return result;
    }
  }

  static String formatToDateString(String isoString) {
    // Parse the ISO string to a DateTime object in the local time zone
    DateTime dateTime = DateTime.parse(isoString);
    DateTime now = DateTime.now();

    // Create date-only objects (without time) for comparison
    DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime todayOnly = DateTime(now.year, now.month, now.day);
    DateTime yesterdayOnly = todayOnly.subtract(const Duration(days: 1));

    if (dateOnly.isAtSameMomentAs(todayOnly)) {
      return 'Today';
    } else if (dateOnly.isAtSameMomentAs(yesterdayOnly)) {
      return 'Yesterday';
    } else {
      return DateFormat('dd MMMM yyyy').format(dateTime);
    }
  }

  static String priceFormat2(double data) {
    // Define a NumberFormat with a space as the grouping separator
    final formatter = NumberFormat("#,##0.00", "en_US");
    formatter.turnOffGrouping(); // Remove default grouping
    String formatted = formatter.format(data).replaceAll(",", " ");

    return formatted;
  }

  static String dateFormat(String date) {
    try {
      if (date.length == 10) {
        DateFormat dateFormat = DateFormat("dd.MM.yyyy");
        DateTime dateTime = dateFormat.parse(date);
        return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
      }

      DateTime dateTime = DateTime.parse(date);

      String formattedDateTime =
          DateFormat('dd.MM.yyyy HH:mm').format(dateTime);

      return formattedDateTime;
    } catch (e) {
      return "";
    }
  }

  static String dateFormat2(DateTime date) {
    DateTime updatedDate = date.add(const Duration(hours: 5));
    String formattedDateTime =
        DateFormat('dd.MM.yyyy HH:mm').format(updatedDate);
    return formattedDateTime;
  }

  static String dateTimeFormat(DateTime date) {
    String formattedDateTime = DateFormat('HH:mm').format(date);
    return formattedDateTime;
  }

  static String priceType(String type) {
    if (type == 'uzs') {
      return "so’m";
    } else {
      return "\$";
    }
  }

  static String dateFormatLed(String date) {
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    DateTime dateTime = dateFormat.parse(date);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String dateFormatDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDateTime = DateFormat('dd.MM.yyyy').format(dateTime);

    return formattedDateTime;
  }

  static String formatUzbekPhoneNumber(String phoneNumber) {
    try {
      if (phoneNumber.length != 13) {
        throw ArgumentError('Invalid Uzbek phone number format.');
      }

      final countryCode = phoneNumber.substring(0, 4); // +998
      final operatorCode = phoneNumber.substring(4, 6); // 90
      final firstPart = phoneNumber.substring(6, 9); // 934
      final secondPart = phoneNumber.substring(9, 11); // 56
      final thirdPart = phoneNumber.substring(11, 13); // 70

      return '$countryCode ($operatorCode) $firstPart-$secondPart-$thirdPart';
    } catch (e) {
      return phoneNumber;
    }
  }

  static double allList(List<num> list) {
    double all = 0;
    for (var element in list) {
      all += element;
    }
    return all;
  }

  static bool isDateDay(DateTime date) {
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      return true;
    } else {
      return false;
    }
  }

  static int doubleInt(double number) {
    if (number % 1 >= 0.5) {
      return (number + 0.5).toInt();
    } else {
      return number.toInt();
    }
  }

  static int daysLeft(String date) {
    if (date.length == 10) {
      // Current date
      DateTime now = DateTime.now();
      // Target date: 2024-11-10T19:00:00.000Z
      DateFormat dateFormat = DateFormat("dd.MM.yyyy");
      DateTime dateTime = dateFormat.parse(date);
      // Calculate the difference in days
      Duration difference = dateTime.difference(now);
      int daysLeft = difference.inDays;
      return daysLeft;
    }
    // Current date
    DateTime now = DateTime.now();
    // Target date: 2024-11-10T19:00:00.000Z
    DateTime targetDate = DateTime.parse(date);
    // Calculate the difference in days
    Duration difference = targetDate.difference(now);
    int daysLeft = difference.inDays;
    return daysLeft;
  }
}
