import { unlink, write, writeSync } from "node:fs";

function test(lol?: string, lul?: number) {
  console.log(lul);
  return "test" + lol;
}

interface MyInterface {
  i: number;
}

interface MyOtherInterface extends MyInterface {
  loop: () => void;
}

const MY_CONST = "test";

class Test implements MyOtherInterface {
  i: number;

  constructor(i: number) {
    this.i = i;
  }

  loop(): void {
    for (let i = 0; i <= this.i; i++) {
      console.log(i)
    }
  }
}

function* myGen() {
  yield 42;
  return 13;
}

const gen = myGen();
const res = gen.next();
console.log(res.value);

const lol = new Test(5);
lol.loop();

console.log(test(MY_CONST));

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

for (const n of [1, 2, 3]) {
  console.log(n);
}

const _a = { b: { c: "" } };

const _b = {
  a: "c",
  b: "a",
  c: "b",
  d: ["a", "b", "c"],
};

const _c = null;
// { ( {  } ) }
