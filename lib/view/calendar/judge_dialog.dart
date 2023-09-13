import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleapp/service/providers/event_provider.dart';

// 編集破棄判定ダイアログ
setCansellButton(context) {
  if (beforeTitle != editTitle ||
      beforeComment != editComment ||
      beforeStartDateTime != startDateTime ||
      beforeEndDateTime != endDateTime ||
      beforeIsOn != isOn) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('編集を破棄'),
              onPressed: () {
                setEventInit();
                Navigator.pushNamed(context, '/calendar');
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text("キャンセル"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
  return Navigator.of(context).pop(true);
}

// 予定削除ダイアログ
void deleteJudgeDialog(context, selectProviders, id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text('予定の削除'),
        content: const Text('本当にこの予定を削除しますか？'),
        actions: [
          CupertinoDialogAction(
            child: const Text('キャンセル'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('削除'),
            onPressed: () {
              deletedb(id);
              selectProviders.setSelectMonth();
              Navigator.pushNamed(context, '/calendar');
            },
          ),
        ],
      );
    },
  );
}
