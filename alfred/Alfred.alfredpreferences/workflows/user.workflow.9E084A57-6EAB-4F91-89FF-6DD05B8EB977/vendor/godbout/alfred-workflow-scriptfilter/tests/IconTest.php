<?php

namespace Tests;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Icon;

final class IconTest extends TestCase
{
    /** @test */
    public function it_may_be_created_with_a_path_only()
    {
        $icon = Icon::create('~/Desktop');

        $this->assertSame(['path' => '~/Desktop'], $icon->toArray());
    }

    /** @test */
    public function it_may_be_created_with_a_path_and_a_fileicon_type()
    {
        $icon = Icon::createFileicon('C:/Windows/LOL');

        $output = [
            'path' => 'C:/Windows/LOL',
            'type' => 'fileicon',
        ];

        $this->assertSame($output, $icon->toArray());
    }

    /** @test */
    public function it_may_be_created_with_a_path_and_a_filetype_type()
    {
        $output = [
            'path' => 'chemin',
            'type' => 'filetype',
        ];

        $icon = Icon::createFiletype('chemin');

        $this->assertSame($output, $icon->toArray());

        $icon = Icon::createFiletype()
            ->path('chemin');

        $this->assertEquals($output, $icon->toArray());
    }

    /** @test */
    public function an_icon_may_be_empty()
    {
        $icon = Icon::create();

        $this->assertSame([], $icon->toArray());
    }
}
