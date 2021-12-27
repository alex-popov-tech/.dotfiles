<?php

namespace Tests\Helpers;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Variable;

final class VariableTest extends TestCase
{
    /** @test */
    public function a_name_and_a_value_may_be_added_through_a_fluent_api()
    {
        $variable = Variable::create()
            ->name('vegetable')
            ->value('carrot');

        $this->assertSame(['vegetable' => 'carrot'], $variable->toArray());
    }

    /** @test */
    public function it_may_add_only_one_variable_through_a_fluent_api()
    {
        $variable = Variable::create()
            ->name('animal')
            ->value('dog')
            ->name('color');

        $this->assertSame(['color' => 'dog'], $variable->toArray());
    }
}
