<script setup lang="ts">
import { unlink, write } from "node:fs";

const t = (a: string, b: string) => {
  console.log(a, b);
  console.log(a, b);
  console.log(a, b);
};
const test = "testing!";


</script>

<template>
  <div>
    {{ test }}
    <div>test</div>
  </div>
</template>

<style lang="scss">
:root {
  --c1: rebeccapurple;
  --c2: yellow;
}
* {
  background-color: var(--c1);
  color: var(--c2);
}
</style>
