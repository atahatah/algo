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
}

/// ２分探索法に対応するデータ構造
class BSTnode<T extends Comparable> {
  BSTnode(this.key, {this.lson, this.rson})
      : assert((lson != null && lson.key < key) || lson == null),
        assert((rson != null && key < rson.key) || rson == null);

  final T key;
  final BSTnode<T>? lson, rson;
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
