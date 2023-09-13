import 'package:scheduleapp/common/constants/datetimes.dart';
import 'package:scheduleapp/model/event.dart';
import 'package:scheduleapp/service/database/database.dart';
import 'package:scheduleapp/service/providers/event_provider.dart';

// データベース編集処理
class EventRepository {
  final EventDao _eventDao;

  EventRepository(this._eventDao);

  // 参照処理
  void selectEventdbRepository() {
    // STEP1:データベース接続・データ参照(リアルタイム)
    final eventStream = _eventDao.watchAllEvents();

    // STEP2:mapの初期化
    eventsMap = {};

    // STEP3:選択月の最初の日を計算・格納
    final firstDayOfMonth =
        DateTime(dtSelectedDate.year, dtSelectedDate.month, 1);

    // STEP4:選択月の最後の日を計算・格納
    final lastDayOfMonth =
        DateTime(dtSelectedDate.year, dtSelectedDate.month + 1, 1);

    // STEP5:選択月の全日付を格納するList作成
    monthDates = <DateTime>[];

    // STEP6:選択月の全日付を格納
    for (var day = firstDayOfMonth;
        day.isBefore(lastDayOfMonth);
        day = day.add(const Duration(days: 1))) {
      monthDates.add(day.toLocal());
    }

    // STEP7:選択された日付のインデックスを取得
    targetIndex = monthDates.indexOf(returnDay(dtSelectedDate));

    eventStream.listen(
      (eventsList) {
        // 日付の年月日が一致するものを格納
        for (final date in monthDates) {
          final eventsForDate = eventsList.where((event) =>
              event.startDateTime.year == date.year &&
              event.startDateTime.month == date.month &&
              event.startDateTime.day == date.day);

          if (eventsForDate.isNotEmpty) {
            final mappedEvents = eventsForDate.map((eventTable) {
              return Event(
                id: eventTable.id,
                eventTitle: eventTable.eventTitle,
                comment: eventTable.comment,
                startDateTime: eventTable.startDateTime,
                endDateTime: eventTable.endDateTime,
                allDayFlag: eventTable.allDayFlag,
              );
            }).toList(); // リストに変換
            eventsMap[DateTime(date.year, date.month, date.day)] = mappedEvents;
          }
        }
      },
    );
  }

  // 登録処理
  Future<void> addEventdbRepository() async {
    final eventDao = database.eventDao;
    final maxId = await eventDao.getMaxId();

    final title = textTitleController.text;
    final content = textCommentController.text;

    final event = EventTable(
      id: maxId + 1,
      eventTitle: title,
      comment: content,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      allDayFlag: isOn,
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    );

    await eventDao.insertEvent(event);
    // selectdb();

    textTitleController.clear();
    textCommentController.clear();
  }

  // 更新処理
  Future<void> updateEventdbRepository(EventTable event) async {
    await _eventDao.updateEvent(event);
  }

  // 削除処理
  Future<void> deleteEventdbRepository(id) async {
    await _eventDao.getEventById(id);
    await _eventDao.deleteEvent(id);
  }
}

/*-----------------------
 参照してlist化
-----------------------*/

// void selectdb() async {
//   final eventDao = database.eventDao;
//   final eventStream = eventDao.watchAllEvents();
//   await for (final events in eventStream) {
//     eventList = events;
//   }
// }
