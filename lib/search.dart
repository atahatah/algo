// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:collection/collection.dart';

/// 逐次探索法
int chikujiTansakuHo(final List list, final target) {
  int i = 0;
  do {
    if (target == list[i]) return i;
    i++;
  } while (i < list.length);
  return -1;
}

/// 番兵付き逐次探索法
int banpei(final List list, final target, final max) {
  final l = [...list, target];

  int i = 0;
  while (l[i] != target) i++;
  if (i < list.length) return i;
  return -1;
}

/// 順序関係を利用した探索
int junjoKankeiWoRiyouShitaTansaku(final List<int> list, final int target) {
  assert(list.isSorted((a, b) => a.compareTo(b)));

  int i = 0;
  do {
    if (list[i] >= target) break;
    i++;
  } while (i < list.length);

  if (list[i] == target) return i;
  return -1;
}

/// m-ブロック法
int mBlockHo(final List<int> list, final int target, {int m = 5}) {
  assert(list.isSorted((a, b) => a.compareTo(b)));

  var j = 0;
  final k = list.length ~/ m;
  while (j <= m - 2) {
    if (target <= list[(j + 1) * k - 1]) break;
    j++;
  }
  var i = j * k;
  final t = min((j + 1) * k - 1, list.length - 1);
  while (i < t) {
    if (target <= list[i]) break;
    i++;
  }

  if (list[i] == target) return i;
  return -1;
}

/// ２分探索法
int niBunTansakuHou(final List<int> list, final int target) {
  assert(list.isSorted((a, b) => a.compareTo(b)));

  final n = list.length;
  if (target < list[0] || list[n - 1] < target) return -1;

  var left = 0;
  var right = n - 1;

  do {
    final mid = (left + right) ~/ 2;
    if (target < list[mid])
      right = mid - 1;
    else
      left = mid + 1;
  } while (left <= right);

  if (target == list[right]) return right;
  return -1;
}

/// ハッシュ法
int hashHou(
    final List<int> htb, final int target, final HashFunctionType hash) {
  var j = hash(target);
  while (htb[j] != 0 && htb[j] != target) j = (j + 1) % htb.length;
  if (htb[j] == target) return j;
  return -1;
}

typedef HashFunctionType = int Function(int);

/// ハッシュテーブルを作成する
///
/// `list`の各要素は0でないことが前提
List<int> createHashTable(
    final List<int> list, final HashFunctionType hash, int size) {
  assert(list.isSorted((a, b) => a.compareTo(b)));

  final n = list.length;

  final htb = List<int>.filled(size, 0);

  for (int i = 0; i <= n - 1; i++) {
    final x = list[i];
    var j = hash(x);
    while (htb[j] != 0) j = (j + 1) % size;
    htb[j] = x;
  }

  return htb;
}

/// 0 <= 返り値 < `hashSize`
HashFunctionType createHashFunction(final int hashSize) {
  return (int i) => i % hashSize;
}
