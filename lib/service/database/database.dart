import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

/*-----------------------
 テーブル名とdao名定義
-----------------------*/
@DriftDatabase(tables: [
  Events,
], daos: [
  EventDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

/*---------------------------
 Driftデータベースの初期化と接続
---------------------------*/
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

/*---------------------------
 イベントテーブル定義
---------------------------*/
@DataClassName('EventTable')
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventTitle => text()();
  TextColumn get comment => text()();
  DateTimeColumn get startDateTime => dateTime()();
  DateTimeColumn get endDateTime => dateTime()();
  BoolColumn get allDayFlag => boolean()();
  DateTimeColumn get createDate => dateTime()();
  DateTimeColumn get updateDate => dateTime()();
}

/*---------------------------
 dao定義(データベース制御)
---------------------------*/
@DriftAccessor(tables: [Events])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  EventDao(AppDatabase db) : super(db);
  // リアルタイムでデータ参照
  Stream<List<EventTable>> watchAllEvents() => select(events).watch();

  // 登録処理
  Future<void> insertEvent(EventTable event) => into(events).insert(event);

  // 最大ID取得
  Future<int> getMaxId() async {
    // 変数定義
    int nCountDate;
    int maxId;

    // 件数確認
    final nCount = await customSelect(
      'SELECT COUNT(*) AS Cnt FROM events',
    ).getSingle();

    // 件数格納
    nCountDate = nCount.read<int>('Cnt');

    // 件数が0件の場合
    if (nCountDate == 0) {
      maxId = 0;

      // 件数ありの場合
    } else {
      // 最大IDを出力クエリ格納
      final result = await customSelect(
        'SELECT MAX(id) AS max_id FROM events',
      ).getSingle();

      // 最大IDを変数に格納
      maxId = result.read<int>('max_id');
    }
    return maxId;
  }

  // 特定のイベントIDのデータ取得
  Future<EventTable?> getEventById(int eventId) async {
    final query = select(events)..where((event) => event.id.equals(eventId));
    return query.getSingle();
  }

  // 更新処理
  Future updateEvent(EventTable event) => update(events).replace(event);

  // 削除処理
  Future deleteEvent(EventTable event) => delete(events).delete(event);
}
