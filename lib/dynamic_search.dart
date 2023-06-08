import 'package:algo/data_structure.dart';

// 配列で実現した２分探索・逐次探索は省略

// 授業資料ではうまく動かなかったので独自実装
void inseartBSTnode<T extends Comparable>(final BSTnode<T> root, final T x) {
  BSTnode<T> v = root;
  while (true) {
    if (x < v.key) {
      if (v.lson == null) {
        v.lson = BSTnode(x);
        return;
      }
      v = v.lson!;
    } else {
      if (v.rson == null) {
        v.rson = BSTnode(x);
        return;
      }
      v = v.rson!;
    }
  }
}

/// returns new root
BSTnode<T>? deleteBSTnode<T extends Comparable>(
  final BSTnode<T> root,
  final T x,
) {
  BSTnode<T>? v = root;
  BSTnode<T>? parent;

  while (v != null) {
    if (v.key == x) break;
    if (v.key > x) {
      parent = v;
      v = v.lson;
    } else {
      parent = v;
      v = v.rson;
    }
  }

  final sonNum = (v!.lson == null ? 0 : 1) + (v.rson == null ? 0 : 1);
  switch (sonNum) {
    case 0:
      // 削除する節点が葉の場合
      if (parent?.lson == v) {
        parent?.lson = null;
      } else if (parent?.rson == v) {
        parent?.rson = null;
      } else {
        return null;
      }
      return root;
    case 1:
      // 削除する節点が子を１つ持つ場合
      if (parent?.lson == v) {
        parent?.lson = v.lson ?? v.rson;
      } else if (parent?.rson == v) {
        parent?.rson = v.lson ?? v.rson;
      } else {
        return v.lson ?? v.rson;
      }
      return root;
    case 2:
      // 削除する節点が子を２個もつ場合
      final maxNode = searchMax(v.lson!);
      final maxKey = maxNode.key;
      deleteBSTnode(v, maxKey);
      v.key = maxKey;
      return root;
    case _:
      throw "(<0 || 2<)となるはずがない";
  }
}

BSTnode<T> searchMax<T extends Comparable>(BSTnode<T> root) {
  return root.rson == null ? root : searchMax(root.rson!);
}
