<?php

namespace Tests\Feature;

use Tests\TestCase;
use Godbout\Alfred\Config;

class ConfigArrayAccessTest extends TestCase
{
    public function setUp(): void
    {
        parent::setUp();

        $this->markTestSkipped('ArrayAccess has been disabled for now.');
    }

    /** @test */
    public function it_is_possible_to_check_whether_a_setting_is_not_set_or_empty_by_using_vanilla_php_functions()
    {
        $config = Config::ifEmptyStartWith([]);

        $this->assertTrue(empty($config['wrong index']));
        $this->assertFalse(isset($config['wrong again']));
    }

    /** @test */
    public function it_is_possible_to_set_a_setting_to_null_by_using_vanilla_php_function_()
    {
        $config = Config::getInstance();
        $config['food'] = 'snails';

        unset($config['food']);

        $this->assertSame(null, $config['food']);
        $this->assertJsonStringEqualsJsonFile(
            $this->configFile,
            json_encode(['food' => null])
        );
    }

    /** @test */
    public function it_is_possible_to_read_a_setting_using_an_array_syntax()
    {
        $defaultConfig = ['language' => 'cantonese'];
        $config = Config::ifEmptyStartWith($defaultConfig);

        $this->assertSame($config['language'], 'cantonese');
    }

    /** @test */
    public function it_is_possible_to_read_a_nested_setting_using_an_array_syntax()
    {
        $defaultConfig = [
            'car' => [
                'brand' => 'renault',
                'model' => 'megane'
            ]
        ];

        $config = Config::ifEmptyStartWith($defaultConfig);

        $this->assertSame($config['car']['brand'], 'renault');
    }

    /** @test */
    public function it_is_possible_to_read_a_nested_setting_using_array_syntax_that_contains_dot_notation()
    {
        $defaultConfig = [
            'writer' => [
                'gender' => 'unknown',
                'age' => 'undecided'
            ]
        ];

        $config = Config::ifEmptyStartWith($defaultConfig);

        $this->assertSame('undecided', $config['writer.age']);
    }

    /** @test */
    public function it_is_possible_to_write_a_setting_using_an_array_syntax()
    {
        $config = Config::getInstance();

        $config['beverage'] = 'beer';

        $this->assertSame('beer', $config['beverage']);
        $this->assertJsonStringEqualsJsonFile(
            $this->configFile,
            json_encode(['beverage' => 'beer'])
        );
    }

    /** @test */
    public function it_is_possible_to_write_a_nested_setting_using_array_syntax()
    {
        $config = Config::getInstance();

        $config['location']['country'] = 'macau';
        $config['location']['city'] = 'well, macau too';

        $this->assertSame($config['location']['city'], 'well, macau too');
        $this->assertJsonStringEqualsJsonFile(
            $this->configFile,
            json_encode(['location' => ['country' => 'macau', 'city' => 'macau']])
        );
    }

    /** @test */
    public function it_is_possible_to_write_a_nested_setting_using_array_syntax_that_contains_dot_notation()
    {
        $config = Config::getInstance();
        $config['timer.harvest.token'] = 'harvest_token';

        $this->assertSame($config['timer']['harvest']['token'], 'harvest_token');
        $this->assertJsonStringEqualsJsonFile(
            $this->configFile,
            json_encode(['timer' => ['harvest' => ['token' => 'harvest_token']]])
        );
    }
}
