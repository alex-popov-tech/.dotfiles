<?php

namespace Tests\Item;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Icon;
use Godbout\Alfred\Workflow\Item;

final class IconTest extends TestCase
{
    public function setUp()
    {
        parent::setUp();

        $this->item = Item::create();
    }

    /** @test */
    public function it_may_have_an_icon()
    {
        $this->item->icon(Icon::create('the path'));

        $this->assertSame(['icon' => ['path' => 'the path']], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_fileicon_icon()
    {
        $this->item->icon(Icon::createFileicon('the path'));

        $this->assertSame(['icon' => ['path' => 'the path', 'type' => 'fileicon']], $this->item->toArray());
    }

    /** @test */
    public function it_may_have_a_filetype_icon()
    {
        $this->item->icon(Icon::createFiletype('the path'));

        $this->assertSame(['icon' => ['path' => 'the path', 'type' => 'filetype']], $this->item->toArray());
    }

    /** @test */
    public function it_cannot_have_multiple_icons()
    {
        $this->item->icon(Icon::createFiletype('the path'));
        $this->item->icon(Icon::createFileicon('another path'));

        $this->assertSame(['icon' => ['path' => 'another path', 'type' => 'fileicon']], $this->item->toArray());
    }
}
