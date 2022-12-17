import { readFileSync } from "fs";
const contents = readFileSync("input.txt", "utf-8");

const lines = contents.split(/\r?\n/);
let sum = 0;
for (const line of lines) {
  const first = line.slice(0, line.length / 2);
  const second = line.slice(line.length / 2);
  const secondSet = new Set(second);
  const commonChar = Array.from(first).find((char) => secondSet.has(char));

  if (!commonChar) {
    throw new Error("No common char.");
  }
  const priority =
    commonChar === commonChar.toLowerCase()
      ? commonChar.charCodeAt(0) - "a".charCodeAt(0) + 1
      : commonChar.charCodeAt(0) - "A".charCodeAt(0) + 27;
  sum += priority;
}

console.log(sum);
