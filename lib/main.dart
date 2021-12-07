import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:core';

import 'package:flutter24/num.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    List<Num> problem = [];
    problem.add(Num.withNum(4));
    problem.add(Num.withNum(4));
    problem.add(Num.withNum(9));
    problem.add(Num.withNum(9));

    GameUtil gameUtil = GameUtil();
    gameUtil.getSolution(problem, []);

    final result = gameUtil.solutions;
    return Text(result.isNotEmpty ? result.join("\n") : "无解");
  }
}

class GameUtil
{
  List<String> solutions = [];

  String getSolution(List<Num> problem, List<String> ops)
  {
    print("$problem...$ops");

    if (problem.length == 1) {
      if (problem[0].equalInt(24)) {
        solutions.add(ops.join(" "));
      }
    }

    SplayTreeSet<String> visited = SplayTreeSet();
    for (int i = 0; i < problem.length; i++) {
      // 如果i和i-1相同没有必要再来一遍
      for (int j = i + 1; j < problem.length; j++) {
        String kk = problem[i].toString() + "," + problem[j].toString();

        if (visited.contains(kk)) continue;

        visited.add(kk);
        List<Num> next = [];
        for (int l = 0; l < problem.length; l++) {
          if (l == i || l == j) continue;

          next.add(problem[l]);
        }

        next.add(Num.origin());
        // 枚举每种运算
        for (int op = 0; op < 6; op++) {
          try {
            Num last = problem[i].calculate(op, problem[j]);
            next[next.length -1] = last;
            List<String> nextOps = List.from(ops);
            nextOps.add(problem[i].operation(op, problem[j]));
            getSolution(next, nextOps);
          } on IntegerDivisionByZeroException {
            print("IntegerDivisionByZeroException");
          }
        }
      }
    }

    return "";
  }
}