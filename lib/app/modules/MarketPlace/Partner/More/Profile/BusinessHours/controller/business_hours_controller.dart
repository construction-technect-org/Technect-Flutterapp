import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';

class BusinessHoursController extends GetxController {
  RxBool isEnabled = true.obs;

  final DashBoardController _dashBoardController = Get.find<DashBoardController>();
  Rx<MerchantBusninessHours?>? busninessHours1 = Rx<MerchantBusninessHours?>(null);
  final HomeService _homeService = Get.find<HomeService>();

  Map<String, RxBool> daysEnabled = {
    "Monday": true.obs,
    "Tuesday": true.obs,
    "Wednesday": true.obs,
    "Thursday": true.obs,
    "Friday": true.obs,
    "Saturday": true.obs,
    "Sunday": false.obs,
  };

  void updateDaysFromApi(Map<String, dynamic> apiDays) {
    apiDays.forEach((day, value) {
      if (daysEnabled.containsKey(day)) {
        daysEnabled[day]!.value = value as bool;
      }
    });
  }

  final Map<String, TextEditingController> fromControllers = {};
  final Map<String, TextEditingController> toControllers = {};

  final Map<String, RxString> fromPeriods = {};
  final Map<String, RxString> toPeriods = {};
  @override
  void onInit() {
    super.onInit();
    print("SAtFRi ${storage.merchnatBizHours?.saturday}");
    busninessHours1?.value = storage.merchnatBizHours;
    print("Saturday ${busninessHours1?.value?.saturday}");

    daysEnabled = {
      "Monday": busninessHours1?.value?.monday?.closed?.obs ?? true.obs,
      "Tuesday": busninessHours1?.value?.tuesday?.closed?.obs ?? true.obs,
      "Wednesday": busninessHours1?.value?.wednesday?.closed?.obs ?? true.obs,
      "Thursday": busninessHours1?.value?.thursday?.closed?.obs ?? true.obs,
      "Friday": busninessHours1?.value?.friday?.closed?.obs ?? true.obs,
      "Saturday": busninessHours1?.value?.saturday?.closed?.obs ?? true.obs,
      "Sunday": busninessHours1?.value?.sunday?.closed?.obs ?? false.obs,
    };
    for (final day in daysEnabled.keys) {
      fromControllers[day] = TextEditingController();
      toControllers[day] = TextEditingController();
      fromPeriods[day] = "AM".obs;
      toPeriods[day] = "PM".obs;
    }

    loadPreviousHours();
  }

  @override
  void onClose() {
    for (final controller in fromControllers.values) {
      controller?.dispose();
    }
    for (final controller in toControllers.values) {
      controller?.dispose();
    }
    super.onClose();
  }

  void validateTimeInput(String value, String day, String type) {
    if (value.isNotEmpty) {
      final int? hour = int.tryParse(value);
      if (hour == null || hour < 0 || hour > 12) {
        if (type == 'from') {
          fromControllers[day]?.clear();
        } else {
          toControllers[day]?.clear();
        }
        SnackBars.errorSnackBar(content: "Please enter valid time (0-12 hours)", time: 2);
      }
    }
  }

  void loadPreviousHours() {
    busninessHours1?.value = storage.merchnatBizHours;
    if (busninessHours1?.value != null) {
      daysEnabled = {
        "Monday": busninessHours1?.value?.monday?.closed?.obs ?? true.obs,
        "Tuesday": busninessHours1?.value?.tuesday?.closed?.obs ?? true.obs,
        "Wednesday": busninessHours1?.value?.wednesday?.closed?.obs ?? true.obs,
        "Thursday": busninessHours1?.value?.thursday?.closed?.obs ?? true.obs,
        "Friday": busninessHours1?.value?.friday?.closed?.obs ?? true.obs,
        "Saturday": busninessHours1?.value?.saturday?.closed?.obs ?? true.obs,
        "Sunday": busninessHours1?.value?.sunday?.closed?.obs ?? false.obs,
      };
      fromControllers["Monday"]!.text = busninessHours1?.value?.monday?.open ?? "";
      fromControllers["Tuesday"]!.text = busninessHours1?.value?.tuesday?.open ?? "";
      fromControllers["Wednesday"]!.text = busninessHours1?.value?.wednesday?.open ?? "";
      fromControllers["Thursday"]!.text = busninessHours1?.value?.thursday?.open ?? "";
      fromControllers["Friday"]!.text = busninessHours1?.value?.friday?.open ?? "";
      fromControllers["Saturday"]!.text = busninessHours1?.value?.saturday?.open ?? "";
      fromControllers["Sunday"]!.text = busninessHours1?.value?.sunday?.open ?? "";

      toControllers["Monday"]!.text = convert24hToAmPm(busninessHours1?.value?.monday?.close) ?? "";
      toControllers["Tuesday"]!.text =
          convert24hToAmPm(busninessHours1?.value?.tuesday?.close) ?? "";
      toControllers["Wednesday"]!.text =
          convert24hToAmPm(busninessHours1?.value?.wednesday?.close) ?? "";
      toControllers["Thursday"]!.text =
          convert24hToAmPm(busninessHours1?.value?.thursday?.close) ?? "";
      toControllers["Friday"]!.text = convert24hToAmPm(busninessHours1?.value?.friday?.close) ?? "";
      toControllers["Saturday"]!.text =
          convert24hToAmPm(busninessHours1?.value?.saturday?.close) ?? "";
      toControllers["Sunday"]!.text = convert24hToAmPm(busninessHours1?.value?.sunday?.close) ?? "";
    }
    busninessHours1?.refresh();
  }

  String? convert24hToAmPm(String? time) {
    if (time != null) {
      final parts = time.split(":");
      if (parts.length != 2) return "Invalid time";

      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);

      if (hour == null || minute == null) return "Invalid time";

      final period = hour >= 12 ? "PM" : "AM";
      final displayHour = hour % 12 == 0 ? 12 : hour % 12;
      final displayMinute = minute.toString().padLeft(2, '0');

      return "$displayHour:$displayMinute";
    } else {
      return null;
    }
  }

  void loadPreviousBusinessHours(List<Map<String, dynamic>> previousData) {
    Get.printInfo(info: '📅 Loading previous business hours data');

    for (final dayData in previousData) {
      final dayName = dayData['day_name'] as String;
      final isOpen = dayData['is_open'] as bool;

      if (daysEnabled.containsKey(dayName)) {
        daysEnabled[dayName]!.value = isOpen;

        if (isOpen && dayData['open_time'] != 'Closed') {
          final openTime = dayData['open_time'] as String;
          final closeTime = dayData['close_time'] as String;

          final openHour = openTime.replaceAll(':00', '');
          final closeHour = closeTime.replaceAll(':00', '');
          String removeAmPm(String time) {
            return time.replaceAll(RegExp('(AM|PM)', caseSensitive: false), "").trim();
          }

          fromControllers[dayName]?.text = removeAmPm(openHour);
          toControllers[dayName]?.text = removeAmPm(closeHour);

          Get.printInfo(info: '📅 Restored $dayName: $openHour - $closeHour');
        } else {
          fromControllers[dayName]?.text = '';
          toControllers[dayName]?.text = '';
          Get.printInfo(info: '📅 $dayName is closed');
        }
      }
    }
  }

  bool isValidTimeRange(String input) {
    final regex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)\s-\s([01]\d|2[0-3]):([0-5]\d)$');

    if (!regex.hasMatch(input)) return false;

    final parts = input.split(' - ');
    final start = parts[0].split(':');
    final end = parts[1].split(':');

    final startMinutes = int.parse(start[0]) * 60 + int.parse(start[1]);
    final endMinutes = int.parse(end[0]) * 60 + int.parse(end[1]);

    return endMinutes > startMinutes;
  }

  String convertAmPmTo24Hour(String time) {
    final regex = RegExp(r'^(\d{1,2}):(\d{2})\s?(AM|PM)$', caseSensitive: false);

    final match = regex.firstMatch(time.trim());
    if (match == null) {
      throw const FormatException("Invalid AM/PM time format");
    }

    int hour = int.parse(match.group(1)!);
    final int minute = int.parse(match.group(2)!);
    final String period = match.group(3)!.toUpperCase();

    if (hour < 1 || hour > 12 || minute < 0 || minute > 59) {
      throw const FormatException("Invalid time values");
    }

    if (period == "AM") {
      hour = hour == 12 ? 0 : hour;
    } else {
      hour = hour == 12 ? 12 : hour + 12;
    }

    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  bool isTimeGreater24(String t1, String t2) {
    int toMinutes(String t) {
      final parts = t.split(':');
      return int.parse(parts[0]) * 60 + int.parse(parts[1]);
    }

    return toMinutes(t1) > toMinutes(t2);
  }

  Future<void> onHoursSubmit() async {
    try {
      if (!isEnabled.value) {
        SnackBars.errorSnackBar(content: "Please enable business hours");
        return;
      }

      // Validate that open days have both from and to times filled
      for (final day in daysEnabled.keys) {
        final isOpen = daysEnabled[day]!.value;
        if (isOpen) {
          final fromText = fromControllers[day]!.text.trim();
          final toText = toControllers[day]!.text.trim();
          if (fromText.isEmpty || toText.isEmpty) {
            SnackBars.errorSnackBar(content: "Please set open and close time for $day");
            return;
          }
        }
      }

      final Map<String, dynamic> _addDays = {};

      for (final day in daysEnabled.keys) {
        final bool isOpen = daysEnabled[day]!.value;

        if (isOpen) {
          // Day is open — use the time values from controllers (already HH:mm 24h format)
          final String openTime = fromControllers[day]!.text.trim();
          final String closeTime = toControllers[day]!.text.trim();

          _addDays[day.toLowerCase()] = {"open": openTime, "close": closeTime, "closed": false};
        } else {
          // Day is closed
          _addDays[day.toLowerCase()] = {"open": null, "close": null, "closed": true};
        }
      }

      print(_addDays);
      final response = await _homeService.updateBusinessHours(storage.merchantID, _addDays);
      if (response) {
        await storage.setMerchantBizHours(MerchantBusninessHours.fromJson(_addDays));
        loadPreviousHours();
        Get.back(result: true);
        SnackBars.successSnackBar(content: "Successfully updated Business Hours");
      } else {
        SnackBars.errorSnackBar(content: "Business Hours Update Failed");
      }
    } catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: "Business Hours Update Failed, try again later");
    }
  }

  void onSubmit() {
    if (!isEnabled.value) {
      SnackBars.errorSnackBar(content: "Please enable business hours");
      return;
    }

    bool hasValidHours = false;
    for (final day in daysEnabled.keys) {
      if (daysEnabled[day]!.value &&
          fromControllers[day]?.text.isNotEmpty == true &&
          toControllers[day]?.text.isNotEmpty == true) {
        final fromHour = int.tryParse(fromControllers[day]!.text);
        final toHour = int.tryParse(toControllers[day]!.text);

        if (fromHour != null &&
            toHour != null &&
            fromHour >= 1 &&
            fromHour <= 24 &&
            toHour >= 1 &&
            toHour <= 24) {
          hasValidHours = true;
        } else {
          SnackBars.errorSnackBar(
            content:
                "Invalid time format for $day. Please enter valid hours (1-24) and ensure 'From' time is before 'To' time",
            time: 4,
          );
          return;
        }
      }
    }

    if (!hasValidHours) {
      SnackBars.errorSnackBar(content: "Please set valid business hours for at least one day");
      return;
    }

    final List<Map<String, dynamic>> businessHoursData = [];
    final Map<String, int> dayToWeekMap = {
      "Monday": 1,
      "Tuesday": 2,
      "Wednesday": 3,
      "Thursday": 4,
      "Friday": 5,
      "Saturday": 6,
      "Sunday": 0,
    };

    for (final day in daysEnabled.keys) {
      final dayOfWeek = dayToWeekMap[day]!;

      if (daysEnabled[day]!.value &&
          fromControllers[day]?.text.isNotEmpty == true &&
          toControllers[day]?.text.isNotEmpty == true) {
        businessHoursData.add({
          "day_of_week": dayOfWeek,
          "day_name": day,
          "is_open": true,
          "open_time":
              "${fromControllers[day]?.text.padLeft(2, '0')}:00 ${fromPeriods[day]!.value}",
          "close_time": "${toControllers[day]?.text.padLeft(2, '0')}:00 ${toPeriods[day]!.value}",
        });
      } else {
        businessHoursData.add({
          "day_of_week": dayOfWeek,
          "day_name": day,
          "is_open": false,
          "open_time": "",
          "close_time": "",
        });
      }
    }

    Get.back(result: businessHoursData);
  }
}
