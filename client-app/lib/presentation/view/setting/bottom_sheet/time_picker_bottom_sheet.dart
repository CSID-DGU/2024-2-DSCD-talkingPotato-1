import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class TimePickerBottomSheet extends StatefulWidget {
  const TimePickerBottomSheet({
    super.key,
    required this.hour,
    required this.minute,
    required this.startedHour,
    required this.endedHour,
    required this.onCompleted,
  });

  final int hour;
  final int minute;

  final int startedHour;
  final int endedHour;
  final Function(int, int) onCompleted;

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late DateTime _current;

  @override
  void initState() {
    super.initState();

    _current = DateTime.now().copyWith(
      hour: widget.hour,
      minute: widget.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: ColorSystem.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width,
            height: 240,
            decoration: BoxDecoration(
              color: ColorSystem.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: FontSystem.H6.copyWith(
                    color: ColorSystem.black,
                    height: 1.0,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                minuteInterval: 15,
                initialDateTime: _current,
                minimumDate: _current.copyWith(
                  hour: widget.startedHour,
                  minute: 0,
                ),
                maximumDate: _current.copyWith(
                  hour: widget.endedHour,
                  minute: 0,
                ),
                onDateTimeChanged: (selectTime) {
                  setState(() {
                    _current = selectTime;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          PrimaryFillButton(
            width: Get.width,
            height: 60,
            content: '완료',
            onPressed: () {
              widget.onCompleted(_current.hour, _current.minute);
            },
          ),
          SizedBox(height: GetPlatform.isAndroid ? 20.0 : 40.0),
        ],
      ),
    );
  }
}
