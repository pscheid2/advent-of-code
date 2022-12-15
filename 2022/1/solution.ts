const { readFileSync } = require("fs");
const contents = readFileSync("input.txt", "utf-8");

const lines = contents.split(/\r?\n/);

const elvesCalories: number[] = [];
let acc = 0;
for (const line of lines) {
  console.log(line);
  if (line === "") {
    elvesCalories.push(acc);
    acc = 0;
  } else {
    acc += parseInt(line, 10);
  }
}
console.log(elvesCalories);
console.log(Math.max(...elvesCalories));
