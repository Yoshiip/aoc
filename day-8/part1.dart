import 'dart:io';

void main() {
  File('input.txt').readAsString().then((String contents) {
    var nodes = [];
    var left_nodes = [];
    var right_nodes = [];

    RegExp exp = RegExp(r'(\w+)');
    var splitted = contents.split("\r\n");
    for (var line in splitted) {
      if (line.contains('=')) {
        Iterable<RegExpMatch> match = exp.allMatches(line);

        nodes.add(match.elementAt(0)[0]);
        left_nodes.add(match.elementAt(1)[0]);
        right_nodes.add(match.elementAt(2)[0]);
      }
    }

    var directions = splitted[0];
    var at = "AAA";
    var total = 0;
    while (at != "ZZZ") {
      var index = nodes.indexOf(at);
      if (directions[total % directions.length] == 'L') {
        at = left_nodes[index];
      } else {
        at = right_nodes[index];
      }
      total += 1;
    }
    print(total);
  });
}
