# The App Scrolls for creating and transforming Rails apps

```
             ___               ____             ____  
            / _ | ___  ___    / __/__________  / / /__
           / __ |/ _ \/ _ \  _\ \/ __/ __/ _ \/ / (_-<
          /_/ |_/ .__/ .__/ /___/\__/_/  \___/_/_/___/
               /_/  /_/                               
```

The App Scrolls is a magical tool to generate new Rails and modify existing Rails applications (coming) to include your favourite, powerful magic. Authentication, testing, persistence, javascript, css, deployment, and templating - there's a magical scroll for you.

* Follow on twitter [@appscrolls][9]

An example application that was built by the App Scrolls is at [https://github.com/drnic/mydemoapp][14]. The generated README shows all the scrolls that were included.

## Installation

Installation is simple:

    gem install appscrolls

## Usage

The primary usage of the `appscrolls` gem is to utilize its interactive terminal command to build a new Rails application. To get started, you can simply run the command thusly:

    appscrolls new APP_NAME

Where `APP_NAME` is the directory in which you wish to create the app (it mirrors the Rails creation syntax). You will then be guided through the scroll selection process and subsequently the Rails app generator will automatically run with the template and all appropriate command line options included.

To transform an existing Rails app, you ... wait, that's not implemented yet. But since the "apply template" feature of `rails new APP_NAME -m template.rb` is implemented in Thor, I mean, how hard could it be?*

### Specifying Scrolls

If you wish to skip the interactive scroll selector, you may provide instead a list of scrolls with the `-s` or `--scrolls` option:

    appscrolls new APP_NAME -s twitter_bootstrap mysql resque
    appscrolls new APP_NAME --scrolls postgresql github eycloud

This will automatically generate a Rails template with the provided scrolls and begin the app generator.

### Listing Scrolls

You can also print out a simple list of scrolls:

    appscrolls list

Or print out a list of scrolls for a specific category:

    appscrolls list persistence

## Deployment Support

Web applications are boring if they aren't running proudly on the internet. The App Scrolls make this automatic for your favourite providers!

### Engine Yard

Scroll: `eycloud`

If you choose the `eycloud` scroll, your application will be automatically deployed to [Engine Yard Cloud][6]. Your code will also be automatically stored on a private/public GitHub repository.

The `eycloud` scroll magically transforms many other scrolls to work specifically for [Engine Yard Cloud][6]. For example:

* `postgresql` - the environment will have PostgreSQL selected instead of MySQL
* `resque` - the environment will have Resque and Redis

### Heroku

The App Scrolls needs a Heroku Master to support Heroku for the App Scrolls. 

There is some initial work in the [current scrolls][11] and the [archived/unsupported scrolls][12]

### CloudFoundry

The App Scrolls needs a CloudFoundry Master to support CloudFoundry for the App Scrolls. 

## Authoring Scrolls of Magical Mystery

Create new scrolls using:

    rake new NAME=scroll-name

Submitting a scroll is actually a very straightforward process. Scrolls are made of up **template code** and **YAML back-matter** stored in a ruby file. The `__END__` parsing convention is used so that each scroll is actually a valid, parseable Ruby file. The structure of a scroll looks something like this:

```ruby
gem 'supergem'

after_bundler do
  generate "supergem:install"
end

__END__

category: templating
name: SuperGem
description: Installs SuperGem which is useful for things
author: mbleigh
```

It's really that simple. The gem has RSpec tests that automatically validate each scroll in the repository, so you should run `rake spec` as a basic sanity check before submitting a pull request. Note that these don't verify that your scroll code itself works, just that App Scrolls could properly parse and understand your scroll file.

## History

This project is an old fashioned fork of [Michael Bleigh][5]'s [Rails Wizard][4]. A new name, new project, and new purpose. 

This project wouldn't exist without Michael having created [Rails Wizard][4] during Rails Rumble and maintaining and upgrading it for a long time. Sadly support dropped off, several recipes did not work with Rails 3.1+, 

[Dr Nic][7] originally worked on [Rails Wizard][4] to provide [Engine Yard Cloud][6] support, his employer and his favourite hosting platform. He also merged in a lot of recipes from other forks, and added new recipes for modern projects.

Support for Engine Yard Cloud meant integration with Chef Recipes. This meant confusing language - Rails Wizard Recipes and Chef Recipes. He decided that wizards don't use recipes - they use scrolls. Alchemists use recipes. And screw alchemists and their dinky potions. Recipes became Scrolls.

## Future

* Automatically setup Continuous Integration for new applications - branches "jenkins"
* Interactive mode is a wizard by categories "pick A, B, C or none"
* Apply scrolls to existing Rails applications - branch "[apply_scrolls][13]"*
* Scrolls work or fail fast on Heroku
* Scrolls work or fail fast on CloudFoundry
* Scrolls generate their own README - branch "readmes"
* 3rd party services/add-ons enabled within deployment platform or directly with service
* Padrino / Sinatra applications
* Non-Ruby applications (Lithium for PHP, etc)

Missing scrolls

* MongoDB - branch "mongodb"
* OmniAuth - branch "omniauth"
* Sidekiq - branch "sidekiq"

How hard could it be?

* `*` 'How hard could it be to transform applications?' - pretty hard. Scrolls need to be aware of the current code base, rather than merely the list of other scrolls being used to create a new app. Scrolls also need to know about versions of Rails rather than just latest rails.

## Thanks

ASCII banner - http://www.network-science.de/ascii/ using 'smslant' font.

## License

App Scrolls and its scrolls are distributed under the MIT License. See [MIT_LICENSE][10] for the actual words.

[1]:http://appscrolls.org/
[2]:https://github.com/drnic/appscrolls
[2]:https://github.com/drnic/appscrolls/tree/master/scrolls
[4]:https://github.com/intridea/rails_wizard
[5]:https://github.com/mbleigh
[6]:http://www.engineyard.com/products/cloud
[7]:http://drnicwilliams.com
[9]:https://twitter.com/elderscrolls
[10]:https://github.com/drnic/appscrolls/blob/master/MIT_LICENSE
[11]:https://github.com/drnic/appscrolls/tree/master/scrolls
[12]:https://github.com/drnic/appscrolls/tree/master/scrolls/zzz
[13]:https://github.com/drnic/appscrolls/tree/apply_scrolls
[14]:https://github.com/drnic/mydemoapp