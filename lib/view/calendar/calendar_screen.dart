import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleapp/common/constants/colors.dart';
import 'package:scheduleapp/service/database/database.dart';
import 'package:scheduleapp/service/providers/event_provider.dart';
import 'package:scheduleapp/view/calendar/event_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

// プロバイダ設定
final selectProvider =
    ChangeNotifierProvider.autoDispose((ref) => SelectDayProvider());
final selectDayProvider =
    ChangeNotifierProvider.autoDispose((ref) => SelectDayProvider());

class CalendarScreen extends ConsumerWidget {
  // ③変数定義(更新なし)
  final DateTime getDate = DateTime.now(); // システム日付

  // ③変数定義(更新あり)
  final DateTime focused = DateTime.now(); // 最初に選択される日
  final DateTime selected = DateTime.now();

  CalendarScreen({Key? key}) : super(key: key); // 選択日

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SelectDayProvider selectDayProviders = ref.watch(selectDayProvider);

    final eventDao = database.eventDao;
    final eventsMap = eventDao.watchAllEvents();

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        return true;
      },
      child: Scaffold(
          backgroundColor: setBackgroundColor(),
          appBar: AppBar(
            title: const Text('カレンダー'),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              // ヘッダー部分
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: setBackgroundColor(), //色
                        ),
                        shape: const StadiumBorder(),
                        elevation: 0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        selectDayProviders.updateDate(getDate, getDate);
                      },
                      child: const Text('今日',
                          style: TextStyle(fontSize: 10, color: Colors.black)),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          selectDayProviders.setCalendar(
                            context,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(
                                '${dtSelectedDate.year.toString()}年${dtSelectedDate.month.toString()}月',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // カレンダー部分
              Container(
                color: Colors.white,
                child: StreamBuilder(
                  stream: eventsMap,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<EventTable>> snapshot) {
                    // イベントマーカー用
                    Map<DateTime, List<String>> events = {};

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    for (final event in snapshot.data!) {
                      // EventTableからstartDateTimeを抽出
                      final startDateTime = event.startDateTime;
                      // イベントの日付を取得
                      final eventDate = DateTime(
                        startDateTime.year,
                        startDateTime.month,
                        startDateTime.day,
                      );

                      // イベントデータをMapに追加
                      events.putIfAbsent(eventDate, () => []);
                      events[eventDate]?.add(event.eventTitle);

                      (eventDate);
                    }
                    return TableCalendar(
                      locale: 'ja_JP',
                      selectedDayPredicate: (day) {
                        return isSameDay(dtSelectedDate, day);
                      },
                      onDaySelected: (dtSelectedDate, dtFocusedDate) {
                        selectDayProviders.updateDate(
                            dtSelectedDate, dtFocusedDate);

                        showDialog(
                          builder: (context) {
                            return PageView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: PageController(
                                viewportFraction: 0.9,
                                initialPage: targetIndex,
                              ),
                              itemCount: monthDates.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.topCenter,
                                  child: EventDialog(monthDates[index]),
                                );
                              },
                            );
                          },
                          context: context,
                        );
                      },
                      eventLoader: (date) {
                        return events[
                                DateTime(date.year, date.month, date.day)] ??
                            [];
                      },
                      firstDay: startDate,
                      lastDay: endDate,
                      focusedDay: dtFocusedDate,
                      headerVisible: false,
                      availableGestures: AvailableGestures.verticalSwipe,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekHeight: 20.0,
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, date, events) {
                          return Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: textColor(date),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
