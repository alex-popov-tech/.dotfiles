<?php

namespace Tests\Item;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Item;

final class TextTest extends TestCase
{
    public function setUp()
    {
        parent::setUp();

        $this->item = Item::create();
    }

    public function it_may_have_a_copy_option()
    {
        $this->item->copy('within text');

        $this->assertSame(['text' => ['copy' => 'within text']], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_largetype_option()
    {
        $this->item->largetype('that IS large');

        $this->assertSame(['text' => ['largetype' => 'that IS large']], $this->item->toArray());
    }

    /** @test */
    public function it_may_set_copy_and_or_largetype_through_the_text_options()
    {
        $this->item->text('mistake', 'wow!');

        $this->assertSame([], $this->item->toArray());

        $this->item->text('copy', 'text to copy');

        $this->assertSame(['text' => ['copy' => 'text to copy']], $this->item->toArray());

        $this->item->text('largetype', 'yeah baby');

        $this->assertSame(['text' => ['copy' => 'text to copy', 'largetype' => 'yeah baby']], $this->item->toArray());

        $this->item->text('copy', 'another text');

        $this->assertSame(['text' => ['copy' => 'another text', 'largetype' => 'yeah baby']], $this->item->toArray());
    }
}
