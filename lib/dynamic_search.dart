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
