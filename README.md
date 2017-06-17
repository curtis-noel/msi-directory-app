# MSI Directory Application

A web-based U.S. map directory that identifies all Minority Serving Institutions (MSI) and USCIS offices.

The federal government recognizes Minority Serving Institutions (MSIs) as valuable resources to the nation. Through Presidential Executive orders and special legislation enacted over the past 20 years, MSIs access federal funds and leverage other resources on behalf of their students and communities. MSIs are: Historically Black Colleges and Universities (HBCUs), Hispanic Serving Institutions (HSIs), Tribal Colleges and Universities (TCUs), Asian Americans and Native American Pacific Islander Serving Institutions (AANAPISIs) and Predominantly Black Institutions (PBIs). In FY 2013, USCIS provided $419,904 to MSIs in the form of grants, services, and equipment donations.

## Windows Developer Environment Prerequisites
1. OS: Windows 7 (64 bit)
1. Rails: [Windows Rails Installer](https://s3.amazonaws.com/railsinstaller/Windows/railsinstaller-3.1.0.exe)
    1. Download the executable file
    1. Run the executable file
    1. Follow the suggested defaults
1. Database: sqlLite - managed by ruby gems

## Windows Test Environment Prerequisites
1. OS: Windows 7 (64 bit)
1. Rails: [Windows Rails Installer](https://s3.amazonaws.com/railsinstaller/Windows/railsinstaller-3.1.0.exe)
    1. Download the executable file
    1. Run the executable file
    1. Follow the suggested defaults
1. Database: PostGreSQL ~> 9.4

## Linux Production Environment Prerequisties
1. OS: Linux OS (RHEL, CentOS, Ubuntu, Amazon Linux)
1. Rails:  Install via [Linux distribution's package manager](https://www.ruby-lang.org/en/documentation/installation/#package-management-systems) from ruby-lang.org.
1. Database: PostGreSQL ~> 9.4

## Installation
From the command prompt within the application directory:
```
# Set install environment (development, test, production)
set RAILS_ENV=development

# Run bundle
bundle install

# Initialize the database (will also reset if needed)
rake db:drop && rake db:create && rake db:migrate && rake db:seed

# Start the web server. Webrick by default for dev, should be nginx for production (TODO)
bundle exec rails s -b 127.0.0.1 -p 3000
```

# Verify Installation
1. Open a web browser and navigate to http://127.0.0.1:3000/
1. Click the Menu>Sign In menu item
1. Sign in with the username `user<id>` (replace `<id>` with an integer from 1-10) and password `password`

## Usage

Click states on map to view all institutions within that state. Use the filter drop-down fields across the top to further filter institutions by Grouping and Region, and to lookup an institution directly.

Sign in via the top-right menu using the above initial development Admin account to access the administration section and to manage users and lookup tables.
