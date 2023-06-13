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

enum NiShoku {
  black,
  red,
  ;

  @override
  String toString() => name[0];
}

class NiShokuGiNode<T extends Comparable> {
  NiShokuGiNode(this.key, this.niShoku, {this.lson, this.rson});

  NiShokuGiNode.from(NiShokuGiNode<T> from)
      : this(
          from.key,
          from.niShoku,
          lson: from.lson,
          rson: from.rson,
        );
  NiShokuGiNode.black() : this(null, NiShoku.black);

  T? key;
  NiShoku niShoku;
  NiShokuGiNode<T>? lson, rson;

  @override
  String toString() => switch ((key, lson, rson)) {
        (null, null, null) => "$niShoku",
        (null, _, null) => "($lson/$niShoku)",
        (null, null, _) => "($niShoku\\$rson)",
        (null, _, _) => "($lson/$niShoku\\$rson)",
        (_, null, null) => "${key}_$niShoku",
        (_, _, null) => "($lson/${key}_$niShoku)",
        (_, null, _) => "(${key}_$niShoku\\$rson)",
        (_, _, _) => "($lson/${key}_$niShoku\\$rson)",
      };

  @override
  bool operator ==(Object other) =>
      other is NiShokuGiNode &&
      other.key == key &&
      other.lson == lson &&
      other.rson == rson &&
      other.niShoku == niShoku;

  @override
  int get hashCode => Object.hash(
        key,
        niShoku,
        lson,
        rson,
      );
}

(
  bool cond,
  int? blackNodeNum,
) niShokuGiHeikoJoken<T extends Comparable>(final NiShokuGiNode<T> root) {
  bool? leftCond, rightCond;
  int? leftBlackNodeNum, rightBlackNodeNum;
  if (root.lson != null) {
    (leftCond, leftBlackNodeNum) = niShokuGiHeikoJoken(root.lson!);
    if (!leftCond) return (false, null);
  }
  if (root.rson != null) {
    (rightCond, rightBlackNodeNum) = niShokuGiHeikoJoken(root.rson!);
    if (!rightCond) return (false, null);
  }

  // (RB0) どの内部節点も２つの子を持つ
  final innerNode = root.lson != null || root.rson != null;
  final rb0 = root.lson != null && root.rson != null;
  if (innerNode && !rb0) return (false, null);

  // (RB1) 各節点は、赤または黒のいずれかの色を持つ
  // これは`NiShokuGiNode`により保証される

  // (RB2) 葉は全て黒である
  //       葉はデータ（キー）を保持しない
  final leaf = root.lson == null || root.rson == null;
  final rb2A = root.niShoku == NiShoku.black;
  final rb2B = root.key == null;
  if (leaf && !(rb2A && rb2B)) return (false, null);

  // (RB3) 赤節点の子は両方とも黒である
  final redNode = root.niShoku == NiShoku.red;
  final rb3 = ((root.lson?.niShoku ?? NiShoku.black) == NiShoku.black) &&
      ((root.rson?.niShoku ?? NiShoku.black) == NiShoku.black);
  if (redNode && !rb3) return (false, null);

  // (RB4) 根から葉までの全経路は同数の黒節点を含む
  final rb4 = leftBlackNodeNum == rightBlackNodeNum;
  if (!rb4) return (false, null);

  var blackNodeNum = leftBlackNodeNum ?? 0;
  if (root.niShoku == NiShoku.black) blackNodeNum++;

  return (true, blackNodeNum);
}

/// a < u < b < v < c
/// (a/u\b)/v\c  =>  a/u\(b/v\c)
NiShokuGiNode<T> rightSingleRotationNishokuGi<T extends Comparable>(
    NiShokuGiNode<T> root) {
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
NiShokuGiNode<T> leftSingleRotationNishokuGi<T extends Comparable>(
    NiShokuGiNode<T> root) {
  assert(root.rson != null);

  final u = root;
  final v = u.rson!;
  final b = v.lson;

  v.lson = u;
  u.rson = b;

  return v;
}

/// 左右２重回転
NiShokuGiNode<T> lrDoubleRotationNishokuGi<T extends Comparable>(
    NiShokuGiNode<T> root) {
  assert(root.lson != null);
  assert(root.lson!.rson != null);

  final w = root;
  final v = root.lson!;

  w.lson = leftSingleRotationNishokuGi(v);
  return rightSingleRotationNishokuGi(w);
}

/// 右左２重回転
NiShokuGiNode<T> rlDoubleRotationNishokuGi<T extends Comparable>(
    NiShokuGiNode<T> root) {
  assert(root.rson != null);
  assert(root.rson!.lson != null);

  final w = root;
  final v = root.rson!;

  w.rson = rightSingleRotationNishokuGi(v);
  return leftSingleRotationNishokuGi(w);
}

NiShokuGiNode<T> insertNiShokuGi<T extends Comparable>(
  final NiShokuGiNode<T> root,
  final T x,
) {
  var v = root;
  final path = <NiShokuGiNode<T>>[v];

  // 2分探索木と同様の方法で挿入
  while (v.key != null) {
    if (x < v.key!) {
      v = v.lson!;
    } else {
      v = v.rson!;
    }
    path.add(v);
  }

  // 空の葉(黒)にキーxを挿入
  v.key = x;
  // xの子として2つの空の葉(黒)を挿入
  v.lson = NiShokuGiNode.black();
  v.rson = NiShokuGiNode.black();
  // xの色を赤に変色(根から葉への経路の黒説点数を保つため)
  v.niShoku = NiShoku.red;

  final reversed = path.reversed.toList();

  if (path.length < 3) {
    if (path.length == 2 && path[1].niShoku == NiShoku.red) {
      path[1].niShoku = NiShoku.black;
    }
    return root;
  }

  var parent = reversed[1];
  var grandParent = reversed[2];
  var uncle =
      ((grandParent.rson == parent) ? grandParent.lson : grandParent.rson)!;

  if (parent.niShoku != NiShoku.red) return root;
  // xの親が赤の時、2色木の変形(変色)が必要

  if (uncle.niShoku == NiShoku.black) {
    // (ii)追加した節点の親の兄弟の節点が黒節点の場合
    final NiShokuGiNode<T> rotated;
    if (x == parent.lson!.key && parent.key == grandParent.lson!.key ||
        x == parent.rson!.key && parent.key == grandParent.rson!.key) {
      rotated = rightSingleRotationNishokuGi(grandParent);
    } else {
      rotated = leftSingleRotationNishokuGi(grandParent);
    }
    return (grandParent == root) ? rotated : root;
  }

  // (i)追加(あるいは色を変更)した節点の親の兄弟の節点が赤接点の場合
  while (true) {
    if (uncle.niShoku != NiShoku.red) break;

    parent.niShoku = NiShoku.black;
    uncle.niShoku = NiShoku.black;
    grandParent.niShoku = NiShoku.red;

    // 祖父要素を赤に変色したので、この要素が2色木平衡条件を満たす必要がある.
    reversed.removeAt(0);
    reversed.removeAt(0);
    if (reversed.length < 3) break;
    parent = reversed[1];
    grandParent = reversed[2];
    uncle =
        (grandParent.rson == parent) ? grandParent.lson! : grandParent.rson!;
  }

  return root;
}
