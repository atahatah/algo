import 'dart:math';

import 'package:algo/search.dart';
import 'package:collection/collection.dart';
import 'package:test/test.dart';

final r = Random();

/// 0 < value <= `max`の乱数を生成
int next(int max, {int? without}) {
  if (without == null) return r.nextInt(max) + 1;

  int result;
  while ((result = r.nextInt(max) + 1) == without) {}
  return result;
}

void main() {
  const targetIndex = 50;
  const length = 100;
  const max = 100;
  const target = 42;

  assert(targetIndex > 0);
  assert(length > targetIndex);
  assert(target < max);

  const formerLength = targetIndex;
  const latterLength = length - targetIndex - 1;
  final former = List.generate(formerLength, (_) => next(max, without: target));
  final latter = List.generate(latterLength, (_) => next(max, without: target));

  assert(!former.contains(target));
  assert(!latter.contains(target));

  final notContained = List<int>.unmodifiable(
    [...former, ...latter, next(max, without: target)],
  );
  final containedFirst = List<int>.unmodifiable(
    [target, ...former, ...latter],
  );
  final containedMiddle = List<int>.unmodifiable(
    [...former, target, ...latter],
  );
  final containedLast = List<int>.unmodifiable(
    [...former, ...latter, target],
  );

  assert(!notContained.contains(target));
  assert(containedFirst.first == target);
  assert(containedMiddle[targetIndex] == target);
  assert(containedLast.last == target);
  assert(notContained.length == length &&
      containedFirst.length == length &&
      containedMiddle.length == length &&
      containedLast.length == length);

  group("逐次探索法", () {
    test('存在しない', () {
      expect(chikujiTansakuHo(notContained, target), -1);
    });
    test('最初', () {
      expect(chikujiTansakuHo(containedFirst, target), 0);
    });
    test('真ん中', () {
      expect(chikujiTansakuHo(containedMiddle, target), targetIndex);
    });
    test('最後', () {
      expect(chikujiTansakuHo(containedLast, target), length - 1);
    });
  });

  group("番兵付き逐次探索法", () {
    test('存在しない', () {
      expect(banpei(notContained, target, max), -1);
    });
    test('最初', () {
      expect(banpei(containedFirst, target, max), 0);
    });
    test('真ん中', () {
      expect(banpei(containedMiddle, target, max), targetIndex);
    });
    test('最後', () {
      expect(banpei(containedLast, target, max), length - 1);
    });
  });

  /// 順序関係を利用した探索用
  final sorted = notContained.sorted((a, b) => a.compareTo(b));

  group("順序関係を利用した探索", () {
    test('存在しない', () {
      expect(
        junjoKankeiWoRiyouShitaTansaku(sorted, target),
        -1,
      );
    });
    test('最初', () {
      expect(
        sorted[junjoKankeiWoRiyouShitaTansaku(sorted, sorted.first)],
        sorted.first,
      );
    });
    test('真ん中', () {
      expect(
        sorted[junjoKankeiWoRiyouShitaTansaku(sorted, sorted[targetIndex])],
        sorted[targetIndex],
      );
    });
    test('最後', () {
      expect(
        sorted[junjoKankeiWoRiyouShitaTansaku(sorted, sorted.last)],
        sorted.last,
      );
    });
  });

  group("m-Block法", () {
    test('存在しない', () {
      expect(
        mBlockHo(sorted, target),
        -1,
      );
    });
    test('最初', () {
      expect(
        sorted[mBlockHo(sorted, sorted.first)],
        sorted.first,
      );
    });
    test('真ん中', () {
      expect(
        sorted[mBlockHo(sorted, sorted[targetIndex])],
        sorted[targetIndex],
      );
    });
    test('最後', () {
      expect(
        sorted[mBlockHo(sorted, sorted.last)],
        sorted.last,
      );
    });
  });

  group("２分探索法", () {
    test('存在しない', () {
      expect(
        niBunTansakuHou(sorted, target),
        -1,
      );
    });
    test('最初', () {
      expect(
        sorted[niBunTansakuHou(sorted, sorted.first)],
        sorted.first,
      );
    });
    test('真ん中', () {
      expect(
        sorted[niBunTansakuHou(sorted, sorted[targetIndex])],
        sorted[targetIndex],
      );
    });
    test('最後', () {
      expect(
        sorted[niBunTansakuHou(sorted, sorted.last)],
        sorted.last,
      );
    });
  });

  group("ハッシュ法", () {
    final hashSize = sorted.length * 2;
    final hash = createHashFunction(hashSize);
    final htb = createHashTable(sorted, hash, hashSize);
    assert((List.from(htb)..removeWhere((element) => element == 0)).length ==
        sorted.length);
    test('存在しない', () {
      expect(
        hashHou(htb, target, hash),
        -1,
      );
    });
    test('最初', () {
      expect(
        htb[hashHou(htb, sorted.first, hash)],
        sorted.first,
      );
    });
    test('真ん中', () {
      expect(
        htb[hashHou(htb, sorted[targetIndex], hash)],
        sorted[targetIndex],
      );
    });
    test('最後', () {
      expect(
        htb[hashHou(htb, sorted.last, hash)],
        sorted.last,
      );
    });
  });
}
