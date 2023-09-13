import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scheduleapp/common/constants/colors.dart';
import 'package:scheduleapp/common/constants/strings.dart';
import 'package:scheduleapp/service/providers/event_provider.dart';

final eventProvider =
    ChangeNotifierProvider.autoDispose((ref) => EventProvider());

// イベント用ダイアログ
class EventDialog extends ConsumerWidget {
  final DateTime date;

  const EventDialog(this.date, {Key? key}) : super(key: key);

  // ダイアログ
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EventProvider eventProviders = ref.watch(eventProvider);
    final valuesList = eventsMap.values.where((events) {
      return events.any((event) {
        // イベントの開始日の情報を変数に格納
        DateTime eventDate = DateTime(event.startDateTime.year,
            event.startDateTime.month, event.startDateTime.day);

        // 変数の日とdateの日が一致しているものを返す
        return eventDate.isAtSameMomentAs(date);
      });
    }).toList();

    return AlertDialog(
        insetPadding: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        title: SizedBox(
          height: 500,
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${DateFormat('yyyy/MM/dd').format(date)}  (${DateFormat.E('ja').format(date)})',
                        style: TextStyle(color: textColor(date), fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          setEventInit();
                          setInitDay(date);
                          Navigator.pushNamed(
                            context,
                            '/add_event',
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                valuesList.isEmpty
                    ? Center(
                        child: Container(
                          height: 400,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: const Text(
                            '予定はありません。',
                            style: TextStyle(fontSize: 15),
                          ),
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.2),
                          )),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: valuesList.length,
                        itemBuilder: (context, index) {
                          final eventsForDate = valuesList[index];
                          final eventWidgets = eventsForDate
                              .map((event) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: InkWell(
                                              onTap: () {
                                                eventProviders.setEditEvent(
                                                  event.eventTitle,
                                                  event.comment,
                                                  event.startDateTime,
                                                  event.endDateTime,
                                                  event.allDayFlag,
                                                );
                                                Navigator.pushNamed(
                                                    context, '/edit_event',
                                                    arguments: event.id);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                margin: setBorder(),
                                                padding: setBorder(),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.2),
                                                  ),
                                                ),
                                                height: 50,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    event.allDayFlag == true
                                                        ? Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 40,
                                                            width: 40,
                                                            child: const Text(
                                                              '終日',
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 40,
                                                            width: 40,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  returnTimeStr(
                                                                      event
                                                                          .startDateTime),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  returnTimeStr(
                                                                      event
                                                                          .endDateTime),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 20,
                                                      child:
                                                          const VerticalDivider(
                                                        thickness: 3,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        width: double.infinity,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          event.eventTitle,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              })
                              .toList()
                              .cast<Widget>(); // Iterable を List に変換

                          return Column(
                            children: eventWidgets,
                          );
                        },
                      )
              ],
            ),
          ),
        ));
  }
}

EdgeInsets setBorder() {
  return const EdgeInsets.only(left: 5, top: 5, right: 5);
}
