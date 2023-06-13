import 'package:algo/data_structure.dart';
import 'package:algo/dynamic_search.dart';
import 'package:test/test.dart';

void main() {
  group("２分探索木", () {
    test("データの挿入", () {
      final bst = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            5,
            rson: BSTnode(8),
          ),
          8,
          rson: BSTnode(
            12,
            rson: BSTnode(13),
          ),
        ),
        15,
        rson: BSTnode(
          25,
          rson: BSTnode(
            lson: BSTnode(26),
            27,
            rson: BSTnode(29),
          ),
        ),
      );

      inseartBSTnode(bst, 10);
      expect(searchBSTnode(bst, 10)?.key, 10);
      expect(searchBSTnode(bst, 8)?.key, 8);
      expect(searchBSTnode(bst, 12)?.key, 12);
      expect(searchBSTnode(bst, 13)?.key, 13);
    });
    final bst = BSTnode(
      lson: BSTnode(
        lson: BSTnode(
          lson: BSTnode(2),
          4,
          rson: BSTnode(
            lson: BSTnode(5),
            6,
          ),
        ),
        8,
        rson: BSTnode(
          12,
          rson: BSTnode(13),
        ),
      ),
      15,
      rson: BSTnode(
        25,
        rson: BSTnode(
          lson: BSTnode(26),
          27,
          rson: BSTnode(29),
        ),
      ),
    );
    test("削除する節点が葉の場合", () {
      final deleted13 = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            4,
            rson: BSTnode(
              lson: BSTnode(5),
              6,
            ),
          ),
          8,
          rson: BSTnode(
            12,
          ),
        ),
        15,
        rson: BSTnode(
          25,
          rson: BSTnode(
            lson: BSTnode(26),
            27,
            rson: BSTnode(29),
          ),
        ),
      );

      expect(deleteBSTnode(BSTnode.from(bst), 13), deleted13);
    });
    test("削除する節点が子を１個持つ場合", () {
      final deleted12 = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            4,
            rson: BSTnode(
              lson: BSTnode(5),
              6,
            ),
          ),
          8,
          rson: BSTnode(13),
        ),
        15,
        rson: BSTnode(
          25,
          rson: BSTnode(
            lson: BSTnode(26),
            27,
            rson: BSTnode(29),
          ),
        ),
      );

      expect(deleteBSTnode(BSTnode.from(bst), 12), deleted12);
    });
    test("削除する節点が子を２個持つ場合", () {
      final deleted8 = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            4,
            rson: BSTnode(5),
          ),
          6,
          rson: BSTnode(
            12,
            rson: BSTnode(13),
          ),
        ),
        15,
        rson: BSTnode(
          25,
          rson: BSTnode(
            lson: BSTnode(26),
            27,
            rson: BSTnode(29),
          ),
        ),
      );
      expect(deleteBSTnode(BSTnode.from(bst), 8), deleted8);
    });
  });
  group("バランスを保つための変形操作", () {
    test("右回転", () {
      final bst = BSTnode(
        lson: BSTnode(
          lson: BSTnode("1a"),
          "2u",
          rson: BSTnode("3b"),
        ),
        "4v",
        rson: BSTnode("5c"),
      );
      expect(
        rightSingleRotation(
          bst,
        ),
        BSTnode(
          lson: BSTnode("1a"),
          "2u",
          rson: BSTnode(
            lson: BSTnode("3b"),
            "4v",
            rson: BSTnode("5c"),
          ),
        ),
      );
    });
    test("左回転", () {
      final bst = BSTnode(
        lson: BSTnode("1a"),
        "2u",
        rson: BSTnode(
          lson: BSTnode("3b"),
          "4v",
          rson: BSTnode("5c"),
        ),
      );
      expect(
        leftSingleRotation(
          bst,
        ),
        BSTnode(
          lson: BSTnode(
            lson: BSTnode("1a"),
            "2u",
            rson: BSTnode("3b"),
          ),
          "4v",
          rson: BSTnode("5c"),
        ),
      );
    });
    test("右回転と左回転", () {
      final bst = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            5,
            rson: BSTnode(8),
          ),
          8,
          rson: BSTnode(
            12,
            rson: BSTnode(13),
          ),
        ),
        15,
        rson: BSTnode(
          25,
          rson: BSTnode(
            lson: BSTnode(26),
            27,
            rson: BSTnode(29),
          ),
        ),
      );
      expect(leftSingleRotation(rightSingleRotation(BSTnode.from(bst))), bst);
    });
    test("左右２重回転", () {
      expect(
        lrDoubleRotation(
          BSTnode(
            lson: BSTnode(
              lson: BSTnode("1a"),
              "2v",
              rson: BSTnode(
                lson: BSTnode("3b"),
                "4u",
                rson: BSTnode("5c"),
              ),
            ),
            "6w",
            rson: BSTnode("7d"),
          ),
        ),
        BSTnode(
          lson: BSTnode(
            lson: BSTnode("1a"),
            "2v",
            rson: BSTnode("3b"),
          ),
          "4u",
          rson: BSTnode(
            lson: BSTnode("5c"),
            "6w",
            rson: BSTnode("7d"),
          ),
        ),
      );
    });
  });
  group("AVL木", () {
    test("AVL木並行条件を満たす", () {
      final avl = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            5,
          ),
          8,
          rson: BSTnode(12),
        ),
        15,
        rson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(17),
            18,
          ),
          20,
          rson: BSTnode(
            lson: BSTnode(22),
            25,
          ),
        ),
      );
      expect(avlGiHeikoJoken(avl).$1, true);
    });
    test("AVL木並行条件を満たさない(１つの子しか持たない節点の子が葉ではない)", () {
      final avl = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            5,
          ),
          8,
          rson: BSTnode(12),
        ),
        15,
        rson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(17),
            18,
          ),
          20,
          rson: BSTnode(
            lson: BSTnode(lson: BSTnode(21), 22),
            25,
          ),
        ),
      );
      expect(avlGiHeikoJoken(avl).$1, false);
    });
    test("AVL木並行条件を満たさない(2つの子を持つ節点の左右の部分木の高さの差が2以上)", () {
      final avl = BSTnode(
        lson: BSTnode(
          lson: BSTnode(
            lson: BSTnode(2),
            5,
            rson: BSTnode(6, rson: BSTnode(7)),
          ),
          8,
          rson: BSTnode(12),
        ),
        15,
        rson: BSTnode(
          lson: BSTnode(
            18,
          ),
          20,
          rson: BSTnode(
            25,
          ),
        ),
      );
      expect(avlGiHeikoJoken(avl).$1, false);
    });
  });
}
