import { readFileSync } from "fs";
const contents = readFileSync("input.txt", "utf-8");

const lines = contents.split(/\r?\n/);

// const stacks = [["Z", "N"], ["M", "C", "D"], ["P"]];
const stacks = [
  ["J", "H", "P", "M", "S", "F", "N", "V"],
  ["S", "R", "L", "M", "J", "D", "Q"],
  ["N", "Q", "D", "H", "C", "S", "W", "B"],
  ["R", "S", "C", "L"],
  ["M", "V", "T", "P", "F", "B"],
  ["T", "R", "Q", "N", "C"],
  ["G", "V", "R"],
  ["C", "Z", "S", "P", "D", "L", "R"],
  ["D", "S", "J", "V", "G", "P", "B", "F"],
];

for (const line of lines) {
  const [p1, p2] = line.split(" from ");
  const quantity = parseInt(p1.replace("move ", ""));
  const [r1, r2] = p2.split(" to ");
  const from = parseInt(r1);
  const to = parseInt(r2.trim());

  console.log(quantity, from, to);

  for (let i = 0; i < quantity; i += 1) {
    const popped = stacks[from - 1].pop();
    if (!popped) {
      throw new Error("balh");
    }
    stacks[to - 1].push(popped);
  }
}

console.log(stacks);
let result = "";
for (const stack of stacks) {
  result += stack[stack.length - 1];
}
console.log(result);
