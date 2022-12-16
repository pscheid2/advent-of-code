import { readFileSync } from "fs";
const contents = readFileSync("input.txt", "utf-8");

const lines = contents.split(/\r?\n/);

/*
A: Rock
B: Paper
C: Scissors

X: Rock
Y: Paper
Z: Scissors
*/
let score = 0;

for (const line of lines) {
  const [opponentMove, expectedOutcome] = line.split(" ");

  // draw
  if (expectedOutcome === "Y") {
    switch (opponentMove) {
      case "A":
        score += 1;
        break;
      case "B":
        score += 2;
        break;
      case "C":
        score += 3;
        break;
    }
  }

  // win
  if (expectedOutcome === "Z") {
    if (opponentMove === "A") {
      score += 2;
    } else if (opponentMove === "B") {
      score += 3;
    } else if (opponentMove === "C") {
      score += 1;
    }
  }

  // lose
  if (expectedOutcome === "X") {
    if (opponentMove === "A") {
      score += 3;
    } else if (opponentMove === "B") {
      score += 1;
    } else if (opponentMove === "C") {
      score += 2;
    }
  }

  // win, lose, draw score
  switch (expectedOutcome) {
    case "X":
      break;
    case "Y":
      score += 3;
      break;
    case "Z":
      score += 6;
      break;
  }
}

console.log(score);
