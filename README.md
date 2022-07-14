# NewHope

Background::
 Princess Leia gets abducted by the insidious Darth Vader. Luke Skywalker then teams up with a Jedi Knight, a pilot and two droids to free her and to save the galaxy from the violent Galactic Empire.


Purpose:
Upload your data source and refresh the Affiliation of individuals in the central database.


System Requirement:

PART 1
As a user, I should be able to upload sample CSV and import the data into
a database. (located in /SAMPLE_FILE/* )
IMPORTER REQUIREMENTS
a. The data needs to load into 3 tables. People, Locations and
Affiliations
b. A Person can belong to many Locations
c. A Person can belong to many Affiliations
d. A Person without an Affiliation should be skipped
e. A Person should have both a first_name and last_name. All fields
need to be validated except for last_name, weapon and vehicle
which are optional.
f. Names and Locations should all be titlecased

PART 2
As a user, I should be able to view these results from the importer in a table.
2. As a user, I should be able to paginate through the results so that I can see a
maximum of 10 results at a time.
3. As a user, I want to type in a search box so that I can filter the results I want to see.
4. As a user, I want to be able to click on a table column heading to reorder the visible
results.


Requirement translation:

- "As a user" - this calls for some sort of Authentication. Using devise for this purpose.
- "The data needs to load into 3 tables. People, Locations and
Affiliations" - 
    - Affiliation table
    - adding people and location

Specifics:

* Ruby version
Rails 7 with Ruby 2.7

* System dependencies

* Configuration

Perform bundler installation
```bundle install```


* Database 

App is currently configured to use sqlite3

Perform rake task for database migration:
```rake db:migrate```


* Run the app

App can be run by triggering PUMA using 
```./bin/dev```
(also starts a process for tailwind)

* ...


* How to run the test suite
