import 'package:algo/data_structure.dart';
import 'package:collection/collection.dart';
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
    test("存在しないデータの探索", () {
      expect(searchBSTnode(root, 22), null);
    });
  });

  group("スタック", () {
    test("配列で実現したスタックのpush, pop", () {
      final testData = [5, 27, 12];
      final stack = ArrayStack<int>(3);

      for (final d in testData) {
        stack.push(d);
      }

      // 各要素が正しく入ったか確認
      for (final d in testData.reversed) {
        expect(stack.pop(), d);
      }
      // 全ての要素がpopされているかを確認
      expect(stack.top, 0);
    });
    test("連結リストで実現したスタックのpush, pop", () {
      final testData = [5, 27, 12];
      final stack = LinkedListStack<int>();

      for (final d in testData) {
        stack.push(d);
      }

      // 各要素が正しく入ったかを確認
      for (final d in testData.reversed) {
        expect(stack.pop(), d);
      }
      // 全ての要素がpopされているかを確認
      expect(stack.head.next, null);
    });
  });

  group("キュー", () {
    test("配列によるキューのenqueue, dequeueによる位置の確認", () {
      final queue = ArrayQueue(11);

      for (final d in [1, 2, 3, 4]) {
        queue.enqueue(d);
        queue.dequeue();
      }
      for (final d in [38, 15, 21, 6]) {
        queue.enqueue(d);
      }

      queue.enqueue(53);
      queue.dequeue();
      queue.enqueue(48);
      queue.enqueue(74);

      expect(queue.head, 5);
      expect(queue.tail, 0);
    });
    test("連結リストによるキューのenqueue, dequeue", () {
      final testData = [3, 2, 6, 1];
      final queue = LinkedListQueue();

      for (final d in testData) {
        queue.enqueue(d);
      }

      for (final d in testData) {
        expect(queue.dequeue(), d);
      }
    });
  });

  group("ヒープ", () {
    test("push, delete max", () {
      final testData = [72, 35, 47, 18, 29, 32, 13, 5, 9, 46]..shuffle();
      final heap = Heap(testData.length + 1);

      for (final d in testData) {
        heap.pushHeap(d);
      }

      // 大きい順に取り出せるかの確認
      for (final d in testData.sorted((a, b) => b.compareTo(a))) {
        expect(heap.deleteMax(), d);
      }
      // 空になっているかの確認
      expect(heap.n, 0);
    });
  });
}
