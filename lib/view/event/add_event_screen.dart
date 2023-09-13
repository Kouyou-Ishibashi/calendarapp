import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scheduleapp/common/constants/edgeInsets.dart';
import 'package:scheduleapp/service/providers/event_provider.dart';

final eventProvider =
    ChangeNotifierProvider.autoDispose((ref) => EventProvider());
final selectProvider =
    ChangeNotifierProvider.autoDispose((ref) => SelectDayProvider());

class AddEventScreen extends ConsumerWidget {
  const AddEventScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SelectDayProvider selectProviders = ref.watch(selectProvider);
    final allDay = ref.watch(eventProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237), //色
      appBar: AppBar(
        title: const Text('予定の追加'),
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop(true);
              setEventInit();
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (addTitle == '' || addComment == '')
                ? TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      '保存',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    onPressed: () {
                      allDay.insertDb();
                      selectProviders.setSelectMonth();
                      Navigator.pushNamed(context, '/calendar');
                    },
                    child: const Text(
                      '保存',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: setMargin(),
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                onChanged: (newText) {
                  allDay.updateTitle(newText);
                },
                controller: textTitleController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'タイトルを入力してください',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: setMargin(),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 1, bottom: 1),
                    child: ListTile(
                      title: const Text('終日'),
                      trailing: Switch(
                        value: isOn,
                        onChanged: (value) {
                          allDay.allDayAction(value);
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 1, bottom: 1),
                    child: ListTile(
                      title: const Text('開始'),
                      trailing: isOn == true
                          ? Text(DateFormat("yyyy-MM-dd")
                              .format(startDateTime)
                              .toString())
                          : Text(DateFormat("yyyy-MM-dd HH:mm")
                              .format(startDateTime)
                              .toString()),
                      onTap: () {
                        // 開始日
                        allDay.showDatePicker(context, 1);
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 1, bottom: 1),
                    child: ListTile(
                      title: const Text('終了'),
                      trailing: isOn == true
                          ? Text(DateFormat("yyyy-MM-dd")
                              .format(endDateTime)
                              .toString())
                          : Text(DateFormat("yyyy-MM-dd HH:mm")
                              .format(endDateTime)
                              .toString()),
                      onTap: () {
                        // 開始日
                        allDay.showDatePicker(context, 2);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: setMargin(),
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                onChanged: (newText) {
                  allDay.updateComment(newText);
                },
                controller: textCommentController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'コメントを入力してください',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
