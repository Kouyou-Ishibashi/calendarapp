// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EventsTable extends Events with TableInfo<$EventsTable, EventTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _eventTitleMeta =
      const VerificationMeta('eventTitle');
  @override
  late final GeneratedColumn<String> eventTitle = GeneratedColumn<String>(
      'event_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateTimeMeta =
      const VerificationMeta('startDateTime');
  @override
  late final GeneratedColumn<DateTime> startDateTime =
      GeneratedColumn<DateTime>('start_date_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateTimeMeta =
      const VerificationMeta('endDateTime');
  @override
  late final GeneratedColumn<DateTime> endDateTime = GeneratedColumn<DateTime>(
      'end_date_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _allDayFlagMeta =
      const VerificationMeta('allDayFlag');
  @override
  late final GeneratedColumn<bool> allDayFlag = GeneratedColumn<bool>(
      'all_day_flag', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("all_day_flag" IN (0, 1))'));
  static const VerificationMeta _createDateMeta =
      const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime> createDate = GeneratedColumn<DateTime>(
      'create_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateDateMeta =
      const VerificationMeta('updateDate');
  @override
  late final GeneratedColumn<DateTime> updateDate = GeneratedColumn<DateTime>(
      'update_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        eventTitle,
        comment,
        startDateTime,
        endDateTime,
        allDayFlag,
        createDate,
        updateDate
      ];
  @override
  String get aliasedName => _alias ?? 'events';
  @override
  String get actualTableName => 'events';
  @override
  VerificationContext validateIntegrity(Insertable<EventTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_title')) {
      context.handle(
          _eventTitleMeta,
          eventTitle.isAcceptableOrUnknown(
              data['event_title']!, _eventTitleMeta));
    } else if (isInserting) {
      context.missing(_eventTitleMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    if (data.containsKey('start_date_time')) {
      context.handle(
          _startDateTimeMeta,
          startDateTime.isAcceptableOrUnknown(
              data['start_date_time']!, _startDateTimeMeta));
    } else if (isInserting) {
      context.missing(_startDateTimeMeta);
    }
    if (data.containsKey('end_date_time')) {
      context.handle(
          _endDateTimeMeta,
          endDateTime.isAcceptableOrUnknown(
              data['end_date_time']!, _endDateTimeMeta));
    } else if (isInserting) {
      context.missing(_endDateTimeMeta);
    }
    if (data.containsKey('all_day_flag')) {
      context.handle(
          _allDayFlagMeta,
          allDayFlag.isAcceptableOrUnknown(
              data['all_day_flag']!, _allDayFlagMeta));
    } else if (isInserting) {
      context.missing(_allDayFlagMeta);
    }
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    } else if (isInserting) {
      context.missing(_updateDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_title'])!,
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment'])!,
      startDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}start_date_time'])!,
      endDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}end_date_time'])!,
      allDayFlag: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}all_day_flag'])!,
      createDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_date'])!,
      updateDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_date'])!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class EventTable extends DataClass implements Insertable<EventTable> {
  final int id;
  final String eventTitle;
  final String comment;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final bool allDayFlag;
  final DateTime createDate;
  final DateTime updateDate;
  const EventTable(
      {required this.id,
      required this.eventTitle,
      required this.comment,
      required this.startDateTime,
      required this.endDateTime,
      required this.allDayFlag,
      required this.createDate,
      required this.updateDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_title'] = Variable<String>(eventTitle);
    map['comment'] = Variable<String>(comment);
    map['start_date_time'] = Variable<DateTime>(startDateTime);
    map['end_date_time'] = Variable<DateTime>(endDateTime);
    map['all_day_flag'] = Variable<bool>(allDayFlag);
    map['create_date'] = Variable<DateTime>(createDate);
    map['update_date'] = Variable<DateTime>(updateDate);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      eventTitle: Value(eventTitle),
      comment: Value(comment),
      startDateTime: Value(startDateTime),
      endDateTime: Value(endDateTime),
      allDayFlag: Value(allDayFlag),
      createDate: Value(createDate),
      updateDate: Value(updateDate),
    );
  }

  factory EventTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventTable(
      id: serializer.fromJson<int>(json['id']),
      eventTitle: serializer.fromJson<String>(json['eventTitle']),
      comment: serializer.fromJson<String>(json['comment']),
      startDateTime: serializer.fromJson<DateTime>(json['startDateTime']),
      endDateTime: serializer.fromJson<DateTime>(json['endDateTime']),
      allDayFlag: serializer.fromJson<bool>(json['allDayFlag']),
      createDate: serializer.fromJson<DateTime>(json['createDate']),
      updateDate: serializer.fromJson<DateTime>(json['updateDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventTitle': serializer.toJson<String>(eventTitle),
      'comment': serializer.toJson<String>(comment),
      'startDateTime': serializer.toJson<DateTime>(startDateTime),
      'endDateTime': serializer.toJson<DateTime>(endDateTime),
      'allDayFlag': serializer.toJson<bool>(allDayFlag),
      'createDate': serializer.toJson<DateTime>(createDate),
      'updateDate': serializer.toJson<DateTime>(updateDate),
    };
  }

  EventTable copyWith(
          {int? id,
          String? eventTitle,
          String? comment,
          DateTime? startDateTime,
          DateTime? endDateTime,
          bool? allDayFlag,
          DateTime? createDate,
          DateTime? updateDate}) =>
      EventTable(
        id: id ?? this.id,
        eventTitle: eventTitle ?? this.eventTitle,
        comment: comment ?? this.comment,
        startDateTime: startDateTime ?? this.startDateTime,
        endDateTime: endDateTime ?? this.endDateTime,
        allDayFlag: allDayFlag ?? this.allDayFlag,
        createDate: createDate ?? this.createDate,
        updateDate: updateDate ?? this.updateDate,
      );
  @override
  String toString() {
    return (StringBuffer('EventTable(')
          ..write('id: $id, ')
          ..write('eventTitle: $eventTitle, ')
          ..write('comment: $comment, ')
          ..write('startDateTime: $startDateTime, ')
          ..write('endDateTime: $endDateTime, ')
          ..write('allDayFlag: $allDayFlag, ')
          ..write('createDate: $createDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventTitle, comment, startDateTime,
      endDateTime, allDayFlag, createDate, updateDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventTable &&
          other.id == this.id &&
          other.eventTitle == this.eventTitle &&
          other.comment == this.comment &&
          other.startDateTime == this.startDateTime &&
          other.endDateTime == this.endDateTime &&
          other.allDayFlag == this.allDayFlag &&
          other.createDate == this.createDate &&
          other.updateDate == this.updateDate);
}

class EventsCompanion extends UpdateCompanion<EventTable> {
  final Value<int> id;
  final Value<String> eventTitle;
  final Value<String> comment;
  final Value<DateTime> startDateTime;
  final Value<DateTime> endDateTime;
  final Value<bool> allDayFlag;
  final Value<DateTime> createDate;
  final Value<DateTime> updateDate;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.eventTitle = const Value.absent(),
    this.comment = const Value.absent(),
    this.startDateTime = const Value.absent(),
    this.endDateTime = const Value.absent(),
    this.allDayFlag = const Value.absent(),
    this.createDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String eventTitle,
    required String comment,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required bool allDayFlag,
    required DateTime createDate,
    required DateTime updateDate,
  })  : eventTitle = Value(eventTitle),
        comment = Value(comment),
        startDateTime = Value(startDateTime),
        endDateTime = Value(endDateTime),
        allDayFlag = Value(allDayFlag),
        createDate = Value(createDate),
        updateDate = Value(updateDate);
  static Insertable<EventTable> custom({
    Expression<int>? id,
    Expression<String>? eventTitle,
    Expression<String>? comment,
    Expression<DateTime>? startDateTime,
    Expression<DateTime>? endDateTime,
    Expression<bool>? allDayFlag,
    Expression<DateTime>? createDate,
    Expression<DateTime>? updateDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventTitle != null) 'event_title': eventTitle,
      if (comment != null) 'comment': comment,
      if (startDateTime != null) 'start_date_time': startDateTime,
      if (endDateTime != null) 'end_date_time': endDateTime,
      if (allDayFlag != null) 'all_day_flag': allDayFlag,
      if (createDate != null) 'create_date': createDate,
      if (updateDate != null) 'update_date': updateDate,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? eventTitle,
      Value<String>? comment,
      Value<DateTime>? startDateTime,
      Value<DateTime>? endDateTime,
      Value<bool>? allDayFlag,
      Value<DateTime>? createDate,
      Value<DateTime>? updateDate}) {
    return EventsCompanion(
      id: id ?? this.id,
      eventTitle: eventTitle ?? this.eventTitle,
      comment: comment ?? this.comment,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      allDayFlag: allDayFlag ?? this.allDayFlag,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventTitle.present) {
      map['event_title'] = Variable<String>(eventTitle.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (startDateTime.present) {
      map['start_date_time'] = Variable<DateTime>(startDateTime.value);
    }
    if (endDateTime.present) {
      map['end_date_time'] = Variable<DateTime>(endDateTime.value);
    }
    if (allDayFlag.present) {
      map['all_day_flag'] = Variable<bool>(allDayFlag.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    if (updateDate.present) {
      map['update_date'] = Variable<DateTime>(updateDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('eventTitle: $eventTitle, ')
          ..write('comment: $comment, ')
          ..write('startDateTime: $startDateTime, ')
          ..write('endDateTime: $endDateTime, ')
          ..write('allDayFlag: $allDayFlag, ')
          ..write('createDate: $createDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $EventsTable events = $EventsTable(this);
  late final EventDao eventDao = EventDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [events];
}

mixin _$EventDaoMixin on DatabaseAccessor<AppDatabase> {
  $EventsTable get events => attachedDatabase.events;
}
