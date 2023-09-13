import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:scheduleapp/repository/event_repository.dart';
import 'package:scheduleapp/service/database/database.dart';

// データベース接続設定
final database = AppDatabase();
final eventDao = database.eventDao;
final eventRepository = EventRepository(eventDao);

/*-----------------------
 変数定義
-----------------------*/
DateTime dtSelectedDate = DateTime.now(); //選択日
DateTime dtFocusedDate = DateTime.now(); //フォーカス日
DateTime startDate = DateTime(DateTime.now().year - 2); // カレンダー開始日
DateTime endDate = DateTime(DateTime.now().year + 2); // カレンダー最終日
DateTime finalDate = DateTime(endDate.year, endDate.month + 1, 1) //
    .subtract(const Duration(days: 1)); // 対象月の1日を抽出
// 対象月に月末日を抽出
int targetIndex = 0;

// イベント追加・編集共通変数
DateTime startDateTime = DateTime.now();
DateTime endDateTime = DateTime.now();
bool isOn = false;

// イベント追加用変数
String addTitle = '';
String addComment = '';

// イベント編集用変数
String editTitle = '';
String editComment = '';
String beforeTitle = '';
String beforeComment = '';
DateTime beforeStartDateTime = DateTime.now();
DateTime beforeEndDateTime = DateTime.now();
bool beforeIsOn = false;

/*-----------------------
 リスト定義
-----------------------*/
// イベント格納用リスト
// List<EventTable> eventList = [];
// 選択月全日付格納List
List<DateTime> monthDates = <DateTime>[];

/*-----------------------
 マップ定義
-----------------------*/
Map eventsMap = {};

/*-----------------------
 コントローラ定義
-----------------------*/
// タイトル用コントローラー
TextEditingController textTitleController = TextEditingController();
// コメント用コントローラー
TextEditingController textCommentController = TextEditingController();
// タイトル編集用コントローラー
TextEditingController editTitleController =
    TextEditingController(text: editTitle);
// コメント編集用コントローラー
TextEditingController editCommentController =
    TextEditingController(text: editComment);

/*----------------------------------
 日付選択時に関するprovider
----------------------------------*/
class SelectDayProvider extends ChangeNotifier {
  /*-----------------------------------------
   選択日の月の全日付とイベント情報をマップ化する処理
  ----------------------------------------- */
  void setSelectMonth() {
    eventRepository.selectEventdbRepository();
    notifyListeners();
  }

  /*-----------------------------------------
   日付ピッカーを用いた選択日付更新処理
  ----------------------------------------- */
  Future<void> setCalendar(context) async {
    // STEP1:日付ピッカーで選ばれた日付を変数に格納
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: dtSelectedDate,
      firstDate: startDate,
      lastDate: finalDate,
    );
    // STEP2:選択日とフォーカス日を日付ピッカーで選択した日付に更新する
    if (datePicked != null && datePicked != dtSelectedDate) {
      // 選択日変数更新
      updateDate(datePicked, datePicked);
    }
    notifyListeners();
  }

  // 選択日・フォーカス日・選択日を更新
  void updateDate(DateTime inSelectedDay, DateTime inFocusedDate) {
    // STEP1:各変数に選択日を格納
    dtSelectedDate = inSelectedDay;
    dtFocusedDate = inFocusedDate;
    setSelectMonth();
    notifyListeners();
  }
}

// 画面遷移時の変数初期化
void setInitDay(day) {
  startDateTime = DateTime(
    day.year,
    day.month,
    day.day,
    DateTime.now().hour,
    0,
  );
  endDateTime = DateTime(
    day.year,
    day.month,
    day.day,
    DateTime.now().add(const Duration(hours: 1)).hour,
    0,
  );
}

// イベント初期化処理
void setEventInit() {
  startDateTime = DateTime.now();
  endDateTime = DateTime.now();
  isOn = false;
  textTitleController.clear();
  textCommentController.clear();
  addTitle = '';
  addComment = '';
}

// 削除処理
Future<void> deletedb(eventId) async {
  final eventDao = database.eventDao;
  EventTable? eventToDelete = await eventDao.getEventById(eventId);

  if (eventToDelete != null) {
    await eventDao.deleteEvent(eventToDelete);
  }
}

// 更新処理
Future<void> updateDb(eventId) async {
  final eventDao = database.eventDao;
  EventTable? eventToEdit = await eventDao.getEventById(eventId);

  if (eventToEdit != null) {
    final title = editTitleController.text;
    final content = editCommentController.text;
    final eventToUpdate = EventTable(
      id: eventId, // 更新するイベントのID
      eventTitle: title,
      comment: content,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      allDayFlag: isOn,
      createDate: eventToEdit.createDate,
      updateDate: DateTime.now(),
    );
    await eventDao.updateEvent(eventToUpdate);
  }
}

/*----------------------------------
 イベントに関するprovider
----------------------------------*/
class EventProvider extends ChangeNotifier {
  // 開始時間と終了時間を設定する
  void setInitialDay(day) {
    startDateTime = DateTime(
      day.year,
      day.month,
      day.day,
      DateTime.now().hour,
      0,
    );
    endDateTime = DateTime(
      day.year,
      day.month,
      day.day,
      DateTime.now().add(const Duration(hours: 1)).hour,
      0,
    );
    notifyListeners();
  }

  // 初期値設定
  void setEditEvent(
    ineditTitle,
    ineditComment,
    instartDateTime,
    inendDateTime,
    inisOn,
  ) {
    editTitle = ineditTitle;
    editComment = ineditComment;
    startDateTime = instartDateTime;
    endDateTime = inendDateTime;
    isOn = inisOn;

    // 修正前文言格納
    beforeTitle = ineditTitle;
    beforeComment = ineditComment;
    beforeStartDateTime = instartDateTime;
    beforeEndDateTime = inendDateTime;
    beforeIsOn = inisOn;

    // 初期値更新
    editTitleController = TextEditingController(text: editTitle);
    editCommentController = TextEditingController(text: editComment);
    notifyListeners();
  }

  // 追加イベントタイトルの更新処理
  void updateTitle(newText) {
    addTitle = newText;
    notifyListeners();
  }

  // 追加イベントコメントの更新処理
  void updateComment(newText) {
    addComment = newText;
    notifyListeners();
  }

  // 追加イベントタイトルの更新処理
  void updateEditTitle(newText) {
    editTitle = newText;
    notifyListeners();
  }

  // 追加イベントコメントの更新処理
  void updateEditComment(newText) {
    editComment = newText;
    notifyListeners();
  }

  // フォーカス日変更用関数
  void allDayAction(bool value) {
    isOn = value;
    notifyListeners();
  }

  // 開始日設定ピッカー
  Future<void> setStartDayPicker(BuildContext context) async {
    final picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2023, 12, 31),
      locale: LocaleType.jp,
    );
    if (picked != null) {
      startDateTime = picked;
      if (endDateTime.isBefore(startDateTime)) {
        endDateTime = startDateTime;
      }
    }
    notifyListeners();
  }

  // 登録処理
  Future<void> insertDb() async {
    eventRepository.addEventdbRepository();
    notifyListeners();
  }

  // 終日か否か
  selectMode() {
    if (isOn == false) {
      // 日付時間分
      return CupertinoDatePickerMode.dateAndTime;
    }
    // 年月日
    return CupertinoDatePickerMode.date;
  }

  // 開始日と終了日の振り分け
  setEventDate(flg, day) {
    if (flg == 1) {
      // 開始日
      startDateTime = day;
    } else {
      // 終了日
      endDateTime = day;
    }
  }

  // 日付の自動調整
  dateComparison() {
    if (isOn == false) {
      // もし開始時間が終了時間よりも未来日の場合、終了時間に開始時間＋1時間を設定する
      if (endDateTime.isBefore(startDateTime)) {
        endDateTime = startDateTime.add(const Duration(hours: 1));
      }
    }
    // もし開始日が終了日よりも未来日の場合、終了日に開始日を設定する
    if (endDateTime.isBefore(startDateTime)) {
      endDateTime = startDateTime;
    }
  }

  // 日付ピッカー
  Future<void> showDatePicker(context, flg) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 285,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'キャンセル',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      dateComparison();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '完了',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 235,
                child: CupertinoDatePicker(
                  backgroundColor: Colors.white,
                  use24hFormat: true,
                  minuteInterval: 15,
                  mode: selectMode(),
                  initialDateTime: startDateTime,
                  minimumDate: DateTime(2000, 1, 1),
                  maximumDate: DateTime(2025, 12, 31),
                  // 変更箇所①
                  onDateTimeChanged: (DateTime newDate) {
                    setEventDate(flg, newDate);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
    notifyListeners();
  }
}
