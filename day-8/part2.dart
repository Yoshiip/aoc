import 'dart:io';

int leastCommonMultiple(int a, int b) {
  if ((a == 0) || (b == 0)) {
    return 0;
  }

  return ((a ~/ a.gcd(b)) * b).abs();
}

bool solved(nodes) {
  var valid = true;
  for (var node in nodes) {
    if (!node.endsWith('Z')) {
      valid = false;
    }
  }
  return valid;
}

int leastCommonMultipleOfMany(List<int> integers) {
  if (integers.length == 0) {
    return 1;
  }

  var lcm = integers[0].abs();

  for (var i = 1; i < integers.length; i++) {
    lcm = leastCommonMultiple(lcm, integers[i]);
  }

  return lcm;
}

void main() {
  File('input.txt').readAsString().then((String contents) {
    var nodes = [];
    var left_nodes = [];
    var right_nodes = [];
    var current_nodes = [];

    RegExp exp = RegExp(r'(\w+)');
    var splitted = contents.split("\r\n");
    for (var line in splitted) {
      if (line.contains('=')) {
        Iterable<RegExpMatch> match = exp.allMatches(line);

        var node_name = match.elementAt(0)[0];
        nodes.add(node_name);
        left_nodes.add(match.elementAt(1)[0]);
        right_nodes.add(match.elementAt(2)[0]);

        if (node_name != null && node_name.endsWith('A')) {
          current_nodes.add(node_name);
        }
      }
    }

    var directions = splitted[0];
    List<int> cycles = [];
    for (var node in current_nodes) {
      var at = node;
      var cycle_step = 0;
      while (!at.endsWith('Z')) {
        var index = nodes.indexOf(at);
        if (directions[cycle_step % directions.length] == 'L') {
          at = left_nodes[index];
        } else {
          at = right_nodes[index];
        }
        cycle_step += 1;
      }
      cycles.add(cycle_step);
    }
    print(leastCommonMultipleOfMany(cycles));
  });
}
