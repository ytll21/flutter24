class Num implements Comparable<Num> {
  int up = 0, down = 0;

  Num.origin();

  Num.withNum(int num) {
    up = num;
    down = 1;
  }

  Num.withUpAndDown(this.up, this.down) {
    simple();
  }

  Num add(Num b) {
    Num c = Num.origin();
    c.down = down * b.down;
    c.up = up * b.down + down * b.up;
    c.simple();
    return c;
  }

  Num sub(Num b) {
    Num c = Num.origin();
    c.down = down * b.down;
    c.up = up * b.down - down * b.up;
    c.simple();
    return c;
  }

  Num mul(Num b) {
    Num c = Num.origin();
    c.down = down * b.down;
    c.up = up * b.up;
    c.simple();
    return c;
  }

  Num div(Num b) {
    Num c = Num.origin();
    c.down = down * b.up;
    c.up = up * b.down;
    c.simple();
    return c;
  }

  int gcd(int x, int y) {
    if (y == 0) return x;

    return gcd(y, x % y);
  }

  void simple() {
    int d = gcd(up, down);
    up = up ~/ d;
    down = down ~/ d;
  }

  @override
  String toString() {
    if (down == 1) {
      return "$up";
    } else {
      return "$up/$down";
    }
  }

  String operation(int func, Num b) {
    Num res = calculate(func, b);

    switch (func) {
      case 0:
        return toString() + "+" + b.toString() + "=" + res.toString();
      case 1:
        return toString() + "-" + b.toString() + "=" + res.toString();
      case 2:
        return toString() + "*" + b.toString() + "=" + res.toString();
      case 3:
        return toString() + "/" + b.toString() + "=" + res.toString();
      case 4:
        return toString() + "-" + toString() + "=" + res.toString();
      case 5:
        return toString() + "/" + toString() + "=" + res.toString();
      default:
        throw Exception("unknown operation $func");
    }
  }

  Num calculate(int whichFunc, Num b) {
    Num ans = Num.origin();
    switch (whichFunc) {
      case 0:
        ans = add(b);
        break;
      case 1:
        ans = sub(b);
        break;
      case 2:
        ans = mul(b);
        break;
      case 3:
        ans = div(b);
        break;
      case 4:
        ans = b.sub(this);
        break;
      case 5:
        ans = b.div(this);
        break;
    }

    return ans;
  }

  bool equalInt(int x) {
    if (down == 1 && up == x) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int compareTo(Num o) {
    Num c = sub(o);
    return c.up * c.down;
  }
}