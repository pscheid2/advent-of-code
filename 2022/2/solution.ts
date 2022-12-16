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
  const [opponentMove, yourMove] = line.split(" ");

  // draw
  if (
    (opponentMove === "A" && yourMove === "X") ||
    (opponentMove === "B" && yourMove === "Y") ||
    (opponentMove === "C" && yourMove === "Z")
  ) {
    score += 3;
    // win
  } else if (
    (opponentMove === "A" && yourMove === "Y") ||
    (opponentMove === "B" && yourMove === "Z") ||
    (opponentMove === "C" && yourMove === "X")
  ) {
    score += 6;
  }
  // else you lose score += 0

  switch (yourMove) {
    case "X":
      score += 1;
      break;
    case "Y":
      score += 2;
      break;
    case "Z":
      score += 3;
      break;
  }
}

console.log(score);
