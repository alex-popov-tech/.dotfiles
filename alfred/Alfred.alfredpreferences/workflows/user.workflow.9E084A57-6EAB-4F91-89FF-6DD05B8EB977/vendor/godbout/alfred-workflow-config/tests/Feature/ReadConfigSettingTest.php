<?php

namespace Tests\Feature;

use Tests\TestCase;
use Godbout\Alfred\Workflow\Config;

class ReadConfigSettingTest extends TestCase
{
    /** @test */
    public function it_returns_null_if_the_setting_requested_doesnt_exist()
    {
        $this->assertNull(Config::read('race'));
    }

    /** @test */
    public function it_can_return_the_value_of_a_non_nested_setting()
    {
        $defaultConfig = [
            'fruit' => 'banana',
            'vegetable' => 'rhubarb'
        ];

        Config::ifEmptyStartWith($defaultConfig);

        $this->assertSame('rhubarb', Config::read('vegetable'));
    }

    /** @test */
    public function it_can_return_the_value_of_a_nested_setting_using_dot_notation_syntax()
    {
        $defaultConfig = [
            'fruit' => [
                'apple' => 'yellow',
                'strawberry' => 'red (with little black dots)'
            ]
        ];

        $config = Config::ifEmptyStartWith($defaultConfig);

        $this->assertSame('yellow', Config::read('fruit.apple'));
    }
}
