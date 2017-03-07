<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class UserTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */

     public function setUp()
    {
        parent::setUp();
                $this->faker = \Faker\Factory::create();

    }
    

    
    
public function test_login_logout()
  {
    $user = factory(\App\User::class)->make();
    $user->save();
    $this->visit('/login');
    $this->type($user->email,'email')
    ->type('secret','password')
     ->press('Login');;
     $this->seePageIs('/home');
     
    }
    
    public function test_logout()
  {
        $user = factory(\App\User::class)->make();
        $user->save();
        $this->visit('/login');
        $this->type($user->email,'email')
        ->type('secret','password')
        ->press('Login');;
        $this->seePageIs('/home');
        
        
        $form = $this->getForm();  
        $this->visit('/')
        ->makeRequestUsingForm($form)
        ->seePageIs('/');

  }
    
}

