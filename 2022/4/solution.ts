import { readFileSync } from "fs";
const contents = readFileSync("input.txt", "utf-8");

const lines = contents.split(/\r?\n/);

let count = 0;
for (const line of lines) {
  const [range1, range2] = line.split(",");
  const [startR1, endR1] = range1.split("-");
  const [startR2, endR2] = range2.split("-");

  if (
    rangesOverlap(
      parseInt(startR1),
      parseInt(endR1),
      parseInt(startR2),
      parseInt(endR2)
    )
  ) {
    count += 1;
  }
}

console.log(count);

function rangesOverlap(
  startR1: number,
  endR1: number,
  startR2: number,
  endR2: number
) {
  if (startR1 >= startR2 && startR1 <= endR2) {
    return true;
  }
  if (endR1 >= startR2 && endR1 <= endR2) {
    return true;
  }
  if (startR2 >= startR1 && startR2 <= endR1) {
    return true;
  }
  if (endR2 >= startR1 && endR2 <= endR1) {
    return true;
  }
  return false;
}
