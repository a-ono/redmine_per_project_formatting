Redmine per project formatting plugin
-----------

This plugin enables text formatting settings per project.

## Plugin installation and setup

1. Copy the plugin directory into the plugins directory (make sure the name is redmine_per_project_formatting)
1. Execute migration

        rake redmine:plugins:migrate RAILS_ENV=production

1. Start Redmine
1. Configure text formatting per project in project settings screen
