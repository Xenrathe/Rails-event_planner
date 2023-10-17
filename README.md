# README

## Model To-do
* User model, adds birthdate column, username column, and bio column
* Character model, which contains attributes: Name, Race, Class, Level, Gender, Backstory/notes, Ruleset
* A USER can have many characters (character belongs_to user)
* Adventure model contains attributes: Name, Ruleset, Module, Description, MaxSeats, Platform, Date/Time, Min Age, Min Level, Max Level, Address, and boolean for Private/Public.
* Enum for Ruleset
* An ADVENTURE can have many characters, INSTEAD of Users. It also has ONE GM, which MUST be the Adventure creator

## View to-do
* Adventure INTRO is the 'main page.' It features an Innkeeper, a small 'upcoming' events, links to everything else.
* Adventure INDEX lists all adventures, with filters for past/upcoming, all/my-character-rulesets/X ruleset, All/Open, MinLvl, MaxLvl. Also a button for "compatible with current character."
* Adventure SHOW shows attributes (Name, Ruleset, Module, Platform, Date/Time, Min Age). It also shows attendee avatars, user e-mail, and seats / maxseats. It also has a button for 'attend' and 'unattend.' For the GM, has buttons for destroy, reserving seats, removing characters, swapping private/public, inviting via e-mail, and editing age, level, module, description, maxseats, platform, date/time.
* User SHOW shows age, username, bio, email, character list, past GM'd and attended events. If this is the user's page, then also shows Delete User, Create New Character, Edit Bio, and upcoming events.
* User/Registration NEW has a better form and updated for new info
* Character SHOW shows all Character model info
* Character NEW/EDIT allows creating a new character or editing an old one
* Upload a bunch of images corresponding to gender / class.