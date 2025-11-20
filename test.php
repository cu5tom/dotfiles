<?php
$test = 'test';
/* a test comment*/

class MyClass {
  public function __construct() {
  }

  protected function test(): void {}
}

$myClass = new MyClass();
?>

<div class="test">
  <?= $test; ?>
</div>

<script>
const test = 123;

const TEST = 'test';

console.log(TEST, test);

function testFn(test) {
<?php /* another test comment */; ?>
  console.log(test);
}

testFn(<?= $test; ?>);
</script>


