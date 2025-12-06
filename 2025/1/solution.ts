import { readFileSync } from "fs";
const contents = readFileSync("input.txt", "utf-8");

const lines = contents.split(/\r?\n/);

let position = 50;
let zeroCount = 0;
for (const line of lines) {
  const direction = line.substr(0,1);
  const amount = parseFloat(line.substr(1));

  for (let i = 0; i < amount; i++) {
    if (direction === 'L') {
      position -= 1;
    } else if (direction === 'R') {
      position += 1;
    } else {
      throw new Error('this shouldnt happen');
    }
  
    if (position % 100 === 0) {
      zeroCount += 1;
    }
  }
  position = position % 100
  if (position < 0) {
    position = 100 + position
  }
  // console.log(`pos ${position} : zeroCount ${zeroCount}`);
}

console.log(zeroCount);
