import { readFileSync } from "fs";
const contents = readFileSync("input.txt", "utf-8");

const lines = contents.split(/\r?\n/);
let sum = 0;
for (let i = 0; i < lines.length; i += 3) {
  const line1 = lines[i];
  const line2 = lines[i + 1];
  const line3 = lines[i + 2];
  const secondSet = new Set(line2);
  const thirdSet = new Set(line3);
  const commonChar = Array.from(line1).find(
    (char) => secondSet.has(char) && thirdSet.has(char)
  );

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
