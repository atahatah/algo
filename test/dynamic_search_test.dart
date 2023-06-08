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
  });
}
