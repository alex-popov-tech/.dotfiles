<?php

namespace Tests\Item;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Item;
use Godbout\Alfred\Workflow\Variable;

final class VariableTest extends TestCase
{
    public function setUp()
    {
        parent::setUp();

        $this->item = Item::create();
    }

    /** @test */
    public function it_may_have_no_variable()
    {
        $this->assertSame([], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_variable()
    {
        $this->item->variable(Variable::create('direction', 'left'));

        $this->assertSame(['variables' => ['direction' => 'left']], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_multiple_variables()
    {
        $this->item->variables(
            Variable::create('race', 'human'),
            Variable::create('color', 'absolutely')
        );

        $output = [
            'variables' => [
                'race' => 'human',
                'color' => 'absolutely',
            ],
        ];

        $this->assertSame($output, $this->item->toArray());
    }
}
