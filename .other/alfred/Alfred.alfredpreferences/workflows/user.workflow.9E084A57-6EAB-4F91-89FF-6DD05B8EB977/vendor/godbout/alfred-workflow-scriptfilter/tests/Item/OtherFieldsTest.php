<?php

namespace Tests\Item;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Item;

final class OtherFieldsTest extends TestCase
{
    public function setUp()
    {
        parent::setUp();

        $this->item = Item::create();
    }

    /** @test */
    public function it_may_have_a_uid()
    {
        $this->item->uid('a uid');

        $this->assertSame(['uid' => 'a uid'], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_title()
    {
        $this->item->title('some title');

        $this->assertSame(['title' => 'some title'], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_subtitle()
    {
        $this->item->subtitle('the subtitle');

        $this->assertSame(['subtitle' => 'the subtitle'], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_an_arg()
    {
        $this->item->arg('argument');

        $this->assertSame(['arg' => 'argument'], $this->item->toArray());
    }

    /** @test */
    public function it_may_be_valid()
    {
        $this->item->valid();

        $this->assertSame(['valid' => true], $this->item->toArray());

        $this->item->valid('slfj');

        $this->assertSame(['valid' => true], $this->item->toArray());

        $this->item->valid(true);

        $this->assertSame(['valid' => true], $this->item->toArray());
    }

    /** @test */
    public function it_may_not_be_valid()
    {
        $this->item->valid(false);

        $this->assertSame(['valid' => false], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_match_option()
    {
        $this->item->match('no fire without a match');

        $this->assertSame(['match' => 'no fire without a match'], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_autocomplete()
    {
        $this->item->autocomplete('a complete auto');

        $this->assertSame(['autocomplete' => 'a complete auto'], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_quicklookurl()
    {
        $this->item->quicklookurl('https://www.alfredapp.com/');

        $this->assertSame(['quicklookurl' => 'https://www.alfredapp.com/'], $this->item->toArray());
    }

    /** @test */
    public function it_throws_an_exception_if_a_non_existing_method_call_is_made()
    {
        $this->expectException(\Exception::class);

        $this->item->bukowski();
    }

    /** @test */
    public function it_throws_an_exception_if_a_non_existing_property_is_getting_get_lol()
    {
        $this->expectException(\Exception::class);

        $this->item->wtf;
    }
}
