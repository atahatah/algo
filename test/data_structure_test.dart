import 'package:algo/data_structure.dart';
import 'package:test/test.dart';

void main() {
  group("配列", () {
    test('挿入と参照', () {
      final testData = [6, 7, 9, 37, 65, 72, 74, 97];

      final array = Array(testData.length);
      for (int i = 0; i < testData.length; i++) {
        array.insert(i, testData[i]);
      }
      for (int i = 0; i < testData.length; i++) {
        expect(array.get(i), testData[i]);
      }
    });
    test('削除', () {
      final testData = [6, 7, 9, 37, 65, 72, 74, 97];

      final array = Array(testData.length);
      for (int i = 0; i < testData.length; i++) {
        array.insert(i, testData[i]);
      }
      array.remove(5);
      testData.removeAt(5);
      for (int i = 0; i < testData.length; i++) {
        expect(array.get(i), testData[i]);
      }
    });
    test('ランダムな位置への挿入', () {
      final testData = [6, 7, 9, 37, 65, 72, 74, 97];

      final array = Array(testData.length);
      for (int i = 0; i < testData.length; i++) {
        array.insert(i, testData[i]);
      }
      array.insert(5, 10);
      testData.insert(5, 10);
      for (int i = 0; i < array.n; i++) {
        expect(array.get(i), testData[i]);
      }
    });
  });
  group("連結リスト", () {
    test('順番に挿入', () {
      final testData = [3, 2, 6, 1];
      final linkedList = LinkedList<int>();
      var previous = linkedList.head;

      for (final d in testData) {
        previous = linkedList.insert(previous, d);
      }

      previous = linkedList.head;
      for (final d in testData) {
        previous = previous.next!;
        expect(previous.data, d);
      }
    });
    test('ランダムな位置に挿入', () {
      final testData1 = [3, 2];
      final testData2 = 4;
      final testData3 = [6, 1];
      final linkedList = LinkedList<int>();
      var previous = linkedList.head;

      for (final d in testData1) {
        previous = linkedList.insert(previous, d);
      }
      final position = previous;
      for (final d in testData3) {
        previous = linkedList.insert(previous, d);
      }
      linkedList.insert(position, testData2);

      previous = linkedList.head;
      for (final d in [...testData1, testData2, ...testData3]) {
        previous = previous.next!;
        expect(previous.data, d);
      }
    });

    test('ランダムな位置の削除', () {
      final testData1 = [3, 2];
      final testData2 = 4;
      final testData3 = [6, 1];
      final linkedList = LinkedList<int>();
      var previous = linkedList.head;

      for (final d in testData1) {
        previous = linkedList.insert(previous, d);
      }
      final position = previous;
      previous = linkedList.insert(position, testData2);
      for (final d in testData3) {
        previous = linkedList.insert(previous, d);
      }
      linkedList.remove(position);

      previous = linkedList.head;
      for (final d in [...testData1, ...testData3]) {
        previous = previous.next!;
        expect(previous.data, d);
      }
    });

    test('最後のセルの削除', () {
      final testData = [3, 2, 4, 6, 1];
      final linkedList = LinkedList<int>();
      var previous = linkedList.head;

      for (final d in testData) {
        previous = linkedList.insert(previous, d);
      }
      linkedList.removeLast();
      testData.removeLast();

      previous = linkedList.head;
      for (final d in testData) {
        previous = previous.next!;
        expect(previous.data, d);
      }
    });
  });

  group("２分探索法に対応するデータ構造", () {
    final root = BSTnode(
        lson: BSTnode(
            lson: BSTnode(lson: BSTnode(3), 5, rson: BSTnode(8)),
            9,
            rson: BSTnode(lson: BSTnode(13), 21, rson: BSTnode(23))),
        50,
        rson: BSTnode(
            lson: BSTnode(lson: BSTnode(53), 62, rson: BSTnode(74)),
            81,
            rson: BSTnode(lson: BSTnode(85), 92, rson: BSTnode(99))));

    test("存在するデータの探索", () {
      expect(searchBSTnode(root, 13)?.key, 13);
    });
    test("存在するデータの探索", () {
      expect(searchBSTnode(root, 22), null);
    });
  });
}
