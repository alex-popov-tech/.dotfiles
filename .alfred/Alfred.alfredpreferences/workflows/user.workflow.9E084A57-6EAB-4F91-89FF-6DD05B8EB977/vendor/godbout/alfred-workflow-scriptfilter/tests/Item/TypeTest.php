<?php

namespace Tests\Item;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Item;

final class TypeTest extends TestCase
{
    /** @test */
    public function it_may_have_a_type_value_of_default()
    {
        $item = Item::createDefault();

        $this->assertSame(['type' => 'default'], $item->toArray());
    }

    /** @test */
    public function it_may_have_a_type_value_of_file()
    {
        $item = Item::createFile();

        $this->assertSame(['type' => 'file'], $item->toArray());
    }

    /** @test */
    public function it_may_have_a_type_value_of_fileskipcheck()
    {
        $item = Item::createSkipcheck();

        $this->assertSame(['type' => 'file:skipcheck'], $item->toArray());
    }

    /** @test */
    public function it_may_have_a_type_value_of_default_through_a_helper_function()
    {
        $item = Item::create()->default();

        $this->assertSame(['type' => 'default'], $item->toArray());
    }

    /** @test */
    public function it_may_have_a_type_value_of_fileskipcheck_through_a_helper_function()
    {
        $item = Item::create()->skipcheck();

        $this->assertSame(['type' => 'file:skipcheck'], $item->toArray());
    }

    /** @test */
    public function it_may_have_a_type_value_of_file_through_a_helper_function()
    {
        $item = Item::create()->file();

        $this->assertSame(['type' => 'file'], $item->toArray());
    }
}
