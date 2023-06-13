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
  group("2色木", () {
    final niShokuGi = NiShokuGiNode(
      lson: NiShokuGiNode(
        lson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            2,
            NiShoku.red,
            rson: NiShokuGiNode.black(),
          ),
          5,
          NiShoku.black,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            6,
            NiShoku.red,
            rson: NiShokuGiNode.black(),
          ),
        ),
        8,
        NiShoku.red,
        rson: NiShokuGiNode(
          lson: NiShokuGiNode.black(),
          12,
          NiShoku.black,
          rson: NiShokuGiNode.black(),
        ),
      ),
      15,
      NiShoku.black,
      rson: NiShokuGiNode(
        lson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            17,
            NiShoku.red,
            rson: NiShokuGiNode.black(),
          ),
          18,
          NiShoku.black,
          rson: NiShokuGiNode.black(),
        ),
        25,
        NiShoku.red,
        rson: NiShokuGiNode(
          lson: NiShokuGiNode.black(),
          27,
          NiShoku.black,
          rson: NiShokuGiNode.black(),
        ),
      ),
    );
    test("2色木平衡条件を満たす", () {
      expect(niShokuGiHeikoJoken(NiShokuGiNode.from(niShokuGi)).$1, true);
    });
    test("2色木平衡条件を満たさない(どの内部節点も2の子を持つ)", () {
      final niShokuGi = NiShokuGiNode(
        lson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              2,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            5,
            NiShoku.black,
            rson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              6,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
          ),
          8,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            12,
            NiShoku.black,
            // rson: NiShokuGiNode.black(),
          ),
        ),
        15,
        NiShoku.black,
        rson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              17,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            18,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
          25,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            27,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
        ),
      );
      expect(niShokuGiHeikoJoken(niShokuGi).$1, false);
    });
    test("2色木平衡条件を満たさない(葉は全て黒である)", () {
      final niShokuGi = NiShokuGiNode(
        lson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              2,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            5,
            NiShoku.black,
            rson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              6,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
          ),
          8,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            12,
            NiShoku.black,
            rson: NiShokuGiNode<int>(null, NiShoku.red),
          ),
        ),
        15,
        NiShoku.black,
        rson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              17,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            18,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
          25,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            27,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
        ),
      );
      expect(niShokuGiHeikoJoken(niShokuGi).$1, false);
    });
    test("2色木平衡条件を満たさない(葉はデータを保持しない)", () {
      final niShokuGi = NiShokuGiNode(
        lson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              2,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            5,
            NiShoku.black,
            rson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              6,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
          ),
          8,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            12,
            NiShoku.black,
            rson: NiShokuGiNode(14, NiShoku.red),
          ),
        ),
        15,
        NiShoku.black,
        rson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              17,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            18,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
          25,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            27,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
        ),
      );
      expect(niShokuGiHeikoJoken(niShokuGi).$1, false);
    });
    test("2色木平衡条件を満たさない(赤節点の子は両方とも黒である)", () {
      final niShokuGi = NiShokuGiNode(
        lson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              2,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            5,
            NiShoku.black,
            rson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              6,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
          ),
          8,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            12,
            NiShoku.red,
            rson: NiShokuGiNode.black(),
          ),
        ),
        15,
        NiShoku.black,
        rson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              17,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            18,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
          25,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            27,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
        ),
      );
      expect(niShokuGiHeikoJoken(niShokuGi).$1, false);
    });
    test("2色木平衡条件を満たさない(根から葉までの全経路は同数の黒節点を持つ)", () {
      final niShokuGi = NiShokuGiNode(
        lson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              2,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            5,
            NiShoku.black,
            rson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              6,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
          ),
          8,
          NiShoku.red,
          rson: NiShokuGiNode.black(),
        ),
        15,
        NiShoku.black,
        rson: NiShokuGiNode(
          lson: NiShokuGiNode(
            lson: NiShokuGiNode(
              lson: NiShokuGiNode.black(),
              17,
              NiShoku.red,
              rson: NiShokuGiNode.black(),
            ),
            18,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
          25,
          NiShoku.red,
          rson: NiShokuGiNode(
            lson: NiShokuGiNode.black(),
            27,
            NiShoku.black,
            rson: NiShokuGiNode.black(),
          ),
        ),
      );
      expect(niShokuGiHeikoJoken(niShokuGi).$1, false);
    });
    test("挿入", () {
      expect(
          niShokuGiHeikoJoken(insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 1))
              .$1,
          true,
          reason: "1");
      expect(
          niShokuGiHeikoJoken(insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 3))
              .$1,
          true,
          reason: "3");
      expect(
          niShokuGiHeikoJoken(insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 7))
              .$1,
          true,
          reason: "7");
      expect(
          niShokuGiHeikoJoken(
                  insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 10))
              .$1,
          true,
          reason: "10");
      expect(
          niShokuGiHeikoJoken(
                  insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 13))
              .$1,
          true,
          reason: "13");
      expect(
          niShokuGiHeikoJoken(
                  insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 16))
              .$1,
          true,
          reason: "16");
      expect(
          niShokuGiHeikoJoken(
                  insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 19))
              .$1,
          true,
          reason: "19");
      expect(
          niShokuGiHeikoJoken(
                  insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 26))
              .$1,
          true,
          reason: "26");
      expect(
          niShokuGiHeikoJoken(
                  insertNiShokuGi(NiShokuGiNode.from(niShokuGi), 28))
              .$1,
          true,
          reason: "28");
    });
  });
}
