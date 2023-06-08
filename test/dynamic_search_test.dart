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
}
