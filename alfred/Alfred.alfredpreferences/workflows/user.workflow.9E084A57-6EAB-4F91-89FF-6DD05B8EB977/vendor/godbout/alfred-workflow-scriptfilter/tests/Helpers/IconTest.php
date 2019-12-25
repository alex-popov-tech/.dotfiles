<?php

namespace Tests\Helpers;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Icon;

final class IconTest extends TestCase
{
    /** @test */
    public function a_path_may_be_added_through_a_fluent_api()
    {
        $icon = Icon::create()
            ->path('chemin');

        $output = [
            'path' => 'chemin',
        ];

        $this->assertSame($output, $icon->toArray());
    }

    /** @test */
    public function a_fileicon_type_may_be_added_through_a_fluent_api()
    {
        $icon = Icon::create('www.web')
            ->fileicon();

        $output = [
            'path' => 'www.web',
            'type' => 'fileicon',
        ];

        $this->assertSame($output, $icon->toArray());
    }

    /** @test */
    public function a_filetype_may_be_added_through_a_fluent_api()
    {
        $icon = Icon::create('$PATH')
            ->filetype();

        $output = [
            'path' => '$PATH',
            'type' => 'filetype',
        ];

        $this->assertSame($output, $icon->toArray());
    }
}
