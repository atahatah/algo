import 'package:meta/meta.dart';

/// 配列
class Array<T> {
  Array(this.n)
      : _array = List<T?>.from(
          <T?>[for (int i = 0; i < n; i++) null],
          growable: false,
        );

  /// 長さ
  final int n;

  final List<T?> _array;

  /// 参照
  T? get(int index) {
    assert(index < n);

    return _array[index];
  }

  /// 挿入
  void insert(int index, T value) {
    assert(index < n);

    var prev = _array[index];
    for (int i = index + 1; i < n; i++) {
      if (prev == null) break;
      final temp = _array[i];
      _array[i] = prev;
      prev = temp;
    }
    _array[index] = value;
  }

  /// 削除
  T? remove(int index) {
    assert(index < n);

    final value = _array[index];
    for (int i = index; i < n - 1; i++) {
      _array[i] = _array[i + 1];
    }
    // 最後はとりあえずnullで埋めておく
    _array[n - 1] = null;

    return value;
  }
}

class LinkedListData<T> {
  LinkedListData({required this.data, required this.next});
  T? data;
  LinkedListData<T>? next;
}

class LinkedList<T> {
  LinkedList();
  // 銭湯セルはダミー（ダータを格納しない）とする
  final LinkedListData<T> head = LinkedListData(data: null, next: null);

  /// 挿入
  LinkedListData<T> insert(LinkedListData<T> after, T value) {
    final newValue = LinkedListData(data: value, next: after.next);
    after.next = newValue;
    return newValue;
  }

  /// 削除
  ///
  /// 実際に削除できるのは指定せるの次のセル
  LinkedListData<T>? remove(LinkedListData<T> data) {
    final removed = data.next;
    data.next = data.next?.next;
    return removed;
  }

  /// 最後のセルの削除
  ///
  /// 最後のセルの直前のセルを見つける
  LinkedListData<T>? removeLast() {
    assert(head.next != null);

    var i = head;
    while (i.next!.next != null) {
      i = i.next!;
    }

    final removed = i.next;
    i.next = null;

    return removed;
  }
}

extension OperatorOnComparable on Comparable {
  bool operator >(Comparable other) => compareTo(other) > 0;
  bool operator <(Comparable other) => compareTo(other) < 0;
  bool operator >=(Comparable other) => compareTo(other) >= 0;
  bool operator <=(Comparable other) => compareTo(other) <= 0;
}
// extension OperatorOnNullableComparable on Comparable? {
//   bool operator >(Comparable? other) => compareTo(other) > 0;
//   bool operator <(Comparable? other) => compareTo(other) < 0;
// }

/// ２分探索法に対応するデータ構造
class BSTnode<T extends Comparable> {
  BSTnode(this.key, {this.lson, this.rson})
      : assert((lson != null && lson.key < key) || lson == null),
        assert((rson != null && key < rson.key) || rson == null);

  BSTnode.from(BSTnode<T> from)
      : this(
          from.key,
          lson: from.lson != null ? BSTnode.from(from.lson!) : null,
          rson: from.rson != null ? BSTnode.from(from.rson!) : null,
        );

  T key;
  BSTnode<T>? lson, rson;

  @override
  String toString() {
    var s = "";
    if (lson != null) {
      s += "$lson ";
    }
    s += "$key ";
    if (rson != null) {
      s += " $rson ";
    }
    return s;
  }

  @override
  bool operator ==(Object other) {
    return other is BSTnode &&
        other.key == key &&
        other.lson == lson &&
        other.rson == rson;
  }

  @override
  int get hashCode => Object.hash(key, lson, rson);
}

/// 探索手続き
///
/// `x`が入力
BSTnode<T>? searchBSTnode<T extends Comparable>(
  final BSTnode<T> root,
  final T x,
) {
  BSTnode<T>? v = root;
  while (v != null) {
    if (v.key == x) return v;
    if (v.key > x) {
      v = v.lson;
    } else {
      v = v.rson;
    }
  }
  return null;
}

/// 配列で実現したスタック
class ArrayStack<T> {
  ArrayStack(this.n) : _stack = List.filled(n, null, growable: false);
  final int n;
  int top = 0;
  final List<T?> _stack;

  void push(T value) {
    _stack[top] = value;
    top++;
  }

  T pop() {
    final removed = _stack[top - 1];
    top--;
    return removed!;
  }
}

/// 連結リストで実現したスタック
class LinkedListStack<T> {
  late var head = LinkedListData<T>(
    data: null,
    next: null,
  );

  void push(T value) {
    head.next = LinkedListData(data: value, next: head.next);
  }

  T? pop() {
    final removed = head.next;
    head.next = head.next?.next;
    return removed?.data;
  }
}

/// 配列によるキューの実現
class ArrayQueue<T> {
  ArrayQueue(this.maxSize)
      : _queue = List.filled(maxSize, null, growable: false);

  final int maxSize;
  int head = 0;
  int tail = 0;
  final List<T?> _queue;
  @visibleForTesting
  List<T?> get queue => _queue;

  void enqueue(T x) {
    tail = (tail + 1) % maxSize;
    _queue[tail] = x;
  }

  T dequeue() {
    head = (head + 1) % maxSize;
    return _queue[head]!;
  }
}

/// 連結リストによるキューの実現
class LinkedListQueue<T> {
  var head = LinkedListData<T>(data: null, next: null);
  late var tail = head;

  void enqueue(T x) {
    tail.next = LinkedListData<T>(data: x, next: null);
    tail = tail.next!;
  }

  T dequeue() {
    final removed = head.next;
    head = head.next!;
    return removed!.data!;
  }
}

/// ヒープ
class Heap<T extends Comparable> {
  Heap(this.maxSize) : _heap = List.filled(maxSize + 1, null);
  final int maxSize;
  final List<T?> _heap;
  var n = 0;

  @visibleForTesting
  List<T?> get heap => _heap;

  void pushHeap(T x) {
    if (++n > maxSize) throw "Heap Overflow";
    int i = n;
    _heap[n] = x;
    while (i > 1 && _heap[i ~/ 2]! < x) {
      _heap[i] = _heap[i ~/ 2];
      i ~/= 2;
    }
    _heap[i] = x;
  }

  T deleteMax() {
    if (n == 0) throw "Heap UnderFlow";
    // 最大である根のデータを取り出す
    final removed = _heap[1];
    // 最後のデータを根に移動し、これを適切な位置まで下す
    final x = _heap[1] = _heap[n];
    n--;

    /// 根に移動したデータの現在位置
    int i = 1;
    while (i * 2 <= n) {
      /// iの子のうち、大きいデータを持つ方がj
      int j = i * 2;
      if (i * 2 + 1 <= n && _heap[i * 2]! < _heap[i * 2 + 1]!) {
        j = i * 2 + 1;
      }
      if (heap[j]! < x!) break;

      // iとjのデータを交換
      _heap[i] = _heap[j];
      i = j;
    }
    heap[i] = heap[n + 1];

    return removed!;
  }
}
