Redmine per project formatting plugin
-----------

This plugin enables text formatting settings per project.
It also be able to change text format per project module. (e.g. issue_tracking, wiki, news, board...)

## Requirements

* Redmine 4.x (version [0.1.0](https://github.com/a-ono/redmine_per_project_formatting/releases/tag/0.1.0))
* Redmine 3.x (version [0.0.5](https://github.com/a-ono/redmine_per_project_formatting/releases/tag/0.0.5))

## Plugin installation and setup

1. Copy the plugin directory into the plugins directory (make sure the name is redmine_per_project_formatting)
1. Execute migration

        rake redmine:plugins:migrate RAILS_ENV=production

1. Start Redmine
1. Configure text formatting per project in project settings screen
