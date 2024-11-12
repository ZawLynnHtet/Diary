import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MonthView(
        controller: EventController(),
        // to provide custom UI for month cells.
        // cellBuilder: (date, events, isToday, isInMonth) {
        //   // Return your widget to display as month cell.
        //   return Container();
        // },
        minMonth: DateTime(1990),
        maxMonth: DateTime(2050),
        initialMonth: DateTime.now(),
        cellAspectRatio: 1,
        onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
        onCellTap: (events, date) {
          // Implement callback when user taps on a cell.
          print(events);
        },
        startDay: WeekDays.sunday, // To change the first day of the week.
        // This callback will only work if cellBuilder is null.
        onEventTap: (event, date) => print(event),
        onEventDoubleTap: (events, date) => print(events),
        onEventLongTap: (event, date) => print(event),
        onDateLongPress: (date) => print(date),
        hideDaysNotInMonth: true,
      ),
    );
  }
}
