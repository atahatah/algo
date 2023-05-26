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
