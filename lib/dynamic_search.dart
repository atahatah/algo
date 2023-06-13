import 'dart:math';

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

/// a < u < b < v < c
/// (a/u\b)/v\c  =>  a/u\(b/v\c)
BSTnode<T> rightSingleRotation<T extends Comparable>(BSTnode<T> root) {
  assert(root.lson != null);

  final v = root;
  final u = v.lson!;
  final b = u.rson;

  u.rson = v;
  v.lson = b;

  return u;
}

/// a < u < b < v < c
/// a/u\(b/v\c)  =>  (a/u\b)/v\c
BSTnode<T> leftSingleRotation<T extends Comparable>(BSTnode<T> root) {
  assert(root.rson != null);

  final u = root;
  final v = u.rson!;
  final b = v.lson;

  v.lson = u;
  u.rson = b;

  return v;
}

/// 左右２重回転
BSTnode<T> lrDoubleRotation<T extends Comparable>(BSTnode<T> root) {
  assert(root.lson != null);
  assert(root.lson!.rson != null);

  final w = root;
  final v = root.lson!;

  w.lson = leftSingleRotation(v);
  return rightSingleRotation(w);
}

/// 右左２重回転
BSTnode<T> rlDoubleRotation<T extends Comparable>(BSTnode<T> root) {
  assert(root.rson != null);
  assert(root.rson!.lson != null);

  final w = root;
  final v = root.rson!;

  w.rson = rightSingleRotation(v);
  return leftSingleRotation(w);
}

(bool condition, int? depth) avlGiHeikoJoken<T extends Comparable>(
    BSTnode<T> root) {
  if (root.lson == null && root.rson == null) return (true, 0);

  var leftDepth = 0;
  var rightDepth = 0;
  if (root.lson != null) {
    final (cond, depth) = avlGiHeikoJoken(root.lson!);
    leftDepth = depth ?? leftDepth;
    if (!cond) return (false, null);
  }
  if (root.rson != null) {
    final (cond, depth) = avlGiHeikoJoken(root.rson!);
    rightDepth = depth ?? leftDepth;
    if (!cond) return (false, null);
  }

  final depth = max(leftDepth, rightDepth) + 1;

  // １つの子しか持たない節点: その子は葉
  if (root.lson == null && root.rson != null) {
    final son = root.rson!;
    final leaf = son.lson == null && son.rson == null;
    return (leaf, depth);
  }
  if (root.lson != null && root.rson == null) {
    final son = root.lson!;
    final leaf = son.lson == null && son.rson == null;
    return (leaf, depth);
  }

  // 2つの子を持つ節点: 左右の部分木の高さの差<=1
  final diffHeight = leftDepth - rightDepth > 0
      ? leftDepth - rightDepth
      : rightDepth - leftDepth;

  return (diffHeight <= 1, depth);
}

int height<T extends Comparable>(BSTnode<T> root) {
  if (root.lson != null) return height(root.lson!) + 1;
  if (root.rson != null) return height(root.rson!) + 1;
  return 0;
}
