
var fs  = require("fs");

fs.readFileSync(process.argv[2]).toString().split('\n').forEach(function (line) {
  if (line !== "") {
    console.log(fizzBuzz(line));
  }
});

function fizzBuzz(line) {
  var arr = line.split(' ')
    , x   = parseInt(arr[0])
    , y   = parseInt(arr[1])
    , n   = parseInt(arr[2])
    , res = [];

  for (var i = 1; i <= n; ++i) {
    var s = '';
    if (i % x === 0)  s += 'F';
    if (i % y === 0)  s += 'B';
    if (s.length > 0) res.push(s);
    else              res.push(i);
  }

  return res.join(' ');
}