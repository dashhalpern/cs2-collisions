// A Pair holds two values.  These values can be of any two types A
// and B, so Pair is parameterized by these types.  To actually use
// Pair, replace A and B with real types.
class Pair<A, B> {
  public final A a;
  public final B b;
  
  Pair(A a_, B b_) {
    a = a_;
    b = b_;
  }
  }