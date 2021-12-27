<?php

namespace Tests;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\ScriptFilter;

final class ScriptFilterUnitTest extends TestCase
{
    /** @test */
    public function it_is_a_singleton()
    {
        $this->assertSame(ScriptFilter::create(), ScriptFilter::create());
    }

    /** @test */
    public function it_may_be_created_through_the_getInstance_method()
    {
        $this->assertNotNull(ScriptFilter::getInstance());
    }

    /** @test */
    public function the_getInstance_is_an_alias_to_the_create_method()
    {
        $this->assertSame(ScriptFilter::getInstance(), ScriptFilter::create());
    }
}
