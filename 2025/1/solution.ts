import { readFileSync } from "fs";
const contents = readFileSync("sample.txt", "utf-8");

const lines = contents.split(/\r?\n/);

let position = 50;
let zeroCount = 0;
for (const line of lines) {
  const direction = line.substr(0,1);
  const amount = parseFloat(line.substr(1));
  // console.log(direction);
  // console.log(amount);

  if (direction === 'L') {
    position = position - amount;
  } else if (direction === 'R') {
    position = position + amount;
  } else {
    throw new Error('this shouldnt happen');
  }

  // zeroCount += Math.abs(Math.floor(position / 100))
  position = position % 100;
  if (position < 0) {
    position = 100 + position;
  }
  if (position === 0) {
    zeroCount += 1;
  }
  console.log(`pos ${position} : zeroCount ${zeroCount}`);
}

console.log(zeroCount);
