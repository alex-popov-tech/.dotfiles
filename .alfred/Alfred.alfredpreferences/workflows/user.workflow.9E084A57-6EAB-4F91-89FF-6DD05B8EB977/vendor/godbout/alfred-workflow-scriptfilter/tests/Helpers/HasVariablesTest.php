<?php

namespace Tests\Helpers;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Item;
use Godbout\Alfred\Workflow\ScriptFilter;

final class HasVariablesTest extends TestCase
{
    /** @test */
    public function it_allows_to_add_a_variable_just_by_giving_the_name_and_value_as_arguments()
    {
        $item = Item::create();

        $item->variable('race', 'human');

        $this->assertSame(['variables' => ['race' => 'human']], $item->toArray());
    }

    /** @test */
    public function it_allows_to_add_multiple_variables_through_a_fluent_api_just_by_giving_the_name_and_value_as_arguments_for_each_call()
    {
        $item = ScriptFilter::create();

        $item->variable('color', 'blue')
            ->variable('size', 'xxl');

        $output = [
            'variables' => [
                'color' => 'blue',
                'size' => 'xxl',
            ],
            'items' => [],
        ];

        $this->assertSame(json_encode($output), $item->output());

        ScriptFilter::destroy();
    }
}
