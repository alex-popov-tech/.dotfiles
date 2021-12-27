<?php

namespace Tests;

use PHPUnit\Framework\TestCase;
use Godbout\Alfred\Workflow\Icon;
use Godbout\Alfred\Workflow\Variable;
use Godbout\Alfred\Workflow\Mods\Ctrl;

final class ModTest extends TestCase
{
    public function setUp()
    {
        parent::setUp();

        $this->mod = new Ctrl;
    }

    /** @test */
    public function it_may_be_valid()
    {
        $output = [
            'valid' => true,
        ];

        $this->mod->valid();

        $this->assertSame($output, $this->mod->toArray());

        $this->mod->valid('WRONG');

        $this->assertSame($output, $this->mod->toArray());

        $this->mod->valid(true);

        $this->assertSame($output, $this->mod->toArray());
    }

    /** @test */
    public function it_may_not_be_valid()
    {
        $this->mod->valid(false);

        $this->assertSame(['valid' => false], $this->mod->toArray());
    }

    /** @test */
    public function it_may_have_an_arg()
    {
        $this->mod->arg('nice arg.');

        $this->assertSame(['arg' => 'nice arg.'], $this->mod->toArray());
    }

    /** @test */
    public function it_may_have_a_subtitle()
    {
        $this->mod->subtitle('eng.srt');

        $this->assertSame(['subtitle' => 'eng.srt'], $this->mod->toArray());
    }

    /** @test */
    public function it_may_have_an_icon()
    {
        $this->mod->icon(Icon::create('~/Dev'));

        $this->assertSame(['icon' => ['path' => '~/Dev']], $this->mod->toArray());

        $this->mod->icon(Icon::createFileicon('another'));

        $this->assertSame(['icon' => ['path' => 'another', 'type' => 'fileicon']], $this->mod->toArray());

        $this->mod->icon(Icon::create('paf')->filetype());

        $this->assertSame(['icon' => ['path' => 'paf', 'type' => 'filetype']], $this->mod->toArray());
    }

    /** @test */
    public function it_cannot_have_multiple_icons()
    {
        $this->mod->icon(Icon::create('~/Dev'));
        $this->mod->icon(Icon::createFileicon('another'));

        $this->assertSame(['icon' => ['path' => 'another', 'type' => 'fileicon']], $this->mod->toArray());
    }

    /** @test */
    public function it_may_have_no_variable()
    {
        $this->assertSame([], $this->mod->toArray());
    }

    /** @test */
    public function it_may_have_one_variable()
    {
        $this->mod->variable('car', 'toyota');

        $output = [
            'variables' => [
                'car' => 'toyota',
            ],
        ];

        $this->assertSame($output, $this->mod->toArray());
    }

    /** @test */
    public function it_may_have_multiple_variables()
    {
        $output = [
            'variables' => [
                'plane' => 'airbus',
                'fruit' => 'apple',
            ],
        ];

        $this->mod->variable(Variable::create('plane', 'airbus'))
            ->variable(Variable::create('fruit', 'apple'));

        $this->assertSame($output, $this->mod->toArray());

        $this->mod->variables(
            Variable::create('plane', 'airbus'),
            Variable::create('fruit', 'apple')
        );

        $this->assertSame($output, $this->mod->toArray());
    }

    /** @test */
    public function it_may_have_empty_variables()
    {
        $output = [
            'variables' => [],
        ];

        $this->mod->variables(Variable::create());

        $this->assertSame($output, $this->mod->toArray());
    }

    /** @test */
    public function it_throws_an_exception_if_a_non_existing_method_call_is_made()
    {
        $this->expectException(\Exception::class);

        $this->mod->bukowski();
    }
}
