<script setup lang="ts">
import { unlink, write } from "node:fs";

/**
 * @augments
 */
function t(a: string, b: string) {
  console.log(a, b);
  console.log(b, a);
  console.log(a, b);
};
// TODO:
// FIXME:
const test = "testing!";

t("fsdfafasd", "42");
</script>

<template>
  <div class="test">
    {{ test }}
    <div data-test="test">test</div>
  </div>
</template>

<style lang="scss">
$c1: rebeccapurple;
$c2: yellow;
:root {
  --c1: #{$c1};
  --c2: yellow;
}

* {
  background-color: var(--c1);
  color: var(--c2);
}
</style>

<style lang="scss">
.test {
  border: 2px solid $c1;
} 
</style>
