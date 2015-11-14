var message = "012222 1114142503 0313012513 03141418192102 0113 2419182119021713 06131715070119"
  , alpha = "BHISOECRTMGWYVALUZDNFJKPQX";

var string = message.split(' ').map(function (word) {
  var s = '', match, twoDigits = /\d{2}/g;
  while (match = twoDigits.exec(word)) {
    s += alpha[parseInt(match[0])];
  }
  return s;
}).join(' ');

var bestScore = 0, bestString = '', currentString, currentScore;

for (var i = 0; i < 26; ++i) {
  currentString = caesarCipher(string, i);
  currentScore = frequencyScore(currentString);

  if (currentScore > bestScore) {
    bestString = currentString;
    bestScore = currentScore;
  }
}

console.log(bestString);

function caesarCipher(string, shift) {
  var s = '';
  for (var i = 0; i < string.length; ++i) {
    if (string[i] === ' ') {
      s += ' ';
      continue;
    }

    var val = string.charCodeAt(i) - 65;
    val = (val + shift) % 26;
    val += 65;

    s += String.fromCharCode(val);
  }
  return s;
}

// ETAOIN SHRDLU
function frequencyScore(string) {
  var score = 0;
  for (var i = 0; i < string.length; ++i) {
    switch (string[i]) {
      case 'E':
        score += 12;
        break;
      case 'T':
        score += 11;
        break;
      case 'A':
        score += 10;
        break;
      case 'O':
        score += 9;
        break;
      case 'I':
        score += 8;
        break;
      case 'N':
        score += 7;
        break;
      case 'S':
        score += 6;
        break
      case 'H':
        score += 5;
        break
      case 'R':
        score += 4;
        break;
      case 'D':
        score += 3;
        break;
      case 'L':
        score += 2;
        break;
      case 'U':
        score += 1;
        break;
    }
  }
  return score;
}