import { readFileSync } from "fs";
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
elvesCalories.push(acc);

elvesCalories.sort((a: number, b: number) => a - b);
console.log(elvesCalories);

const result = elvesCalories.slice(elvesCalories.length - 3);
console.log(result);
console.log(
  result.reduce((acc: number, element: number) => (acc += element), 0)
);
