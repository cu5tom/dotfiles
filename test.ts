import { unlink, write } from "node:fs";

function test(lol?: string, lul?: number) {
  console.log(lul);
  return "test" + lol;
}

console.log(test("rofl"));
console.log(test("rofl"));
console.log(test("rofl"));

if (true) {
  console.log("it's true!");
}

for (const n of [1, 2, 3]) {
  console.log(n);
}

for (const i of []) {
 console.log(i);
}

for (const i of [1, 2, 3]) {
  test("test", i)
}

for (const n of [1,2,3]) {
  console.log(n);
}

const _a = { b: { c: "" } };

const _b = {
  a: "c",
  b: "a",
  c: "b",
  d: ["a", "b", "c"],
};
// { ( {  } ) }
