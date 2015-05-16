#Aptitune

  - [Aptitune GitHub repo](https://github.com/bennettslin/music_abdp)
  - [Aptitune on Heroku](http://aptitune.herokuapp.com)

Aptitune broadens your horizons and tests your knowledge of musical artists by playing sample clips and posing three trivia questions per track. Once logged in, you can select your preferred genres, and even add the tracks you love to your Listen List.

###How To Play

1. Click Start Quiz to test your knowledge of any music genre. Or else login and choose your genre preferences in Dashboard => Genres / Profile.

2. For each track, you will be asked to name the artist, album, and track title.

3. After each quiz, you can save the song to your favorites, stored in Dashboard => Listen List. Or just skip to the next one.

Check the Leaderboards to compare yourself to the top-ranked players. Or login through Facebook and compare yourself to your friends in Dashboard => Friends.

For each correct answer, you gain three trophies. But be careful—for each incorrect guess, you also lose one!

##Developers

Aptitune was developed by Patrick Eldridge, Bennett Lin, Allie Moses, and Daniel Smith, students of General Assembly's Web Development Immersive.

##Version

1.0.0

##Tech

Aptitune was built using Ruby on Rails, HTML5, CSS3, Bootstrap, JavaScript, jQuery, PostgreSQL, iTunes API, D3.js, OAuth (Facebook, Google, LinkedIn, Twitter), bcrypt, iCheck.

##Challenges

The biggest challenge was coming up with an idea. Our group wanted to create an app that we could feel passionately about. Eventually, Aptitune came to fruition. We are all very pleased with the concept and outcome, and we're proud to add this creation to our portfolios.

Some other challenges were ensuring that the final version deployed to Heroku worked correctly, switching from the Spotify API to iTunes during the final stage of the project, and choosing amongst various frontend design decisions.

##Known issues

- When the user favourites a song, sometimes wrong song is being saved. Possibly because a single class variable is being used to store each user's quiz song.
- Player does not automatically start on mobile.

##Contributions

- ###Patrick Eldridge
    - Worked with Spotify API to narrow selection by genre and artist
    - Implemented artist/genre arrays to allow the controller to pull search data
    - Implemented iCheck plugin
    - Added 'delete' functionality through Ajax call in Listen List
    - Contributed to database models and associations between User, Genre, and Song

- ###Bennett Lin
    - Created primary app scaffolding and database models
    - Wrote RSpec tests for controllers and models
    - Implemented encryption and OAuth
    - Created visualisations for Leaderboard data into D3
    - Served as Git Master, managing pull requests and merge conflicts
    - Managed Heroku deployment

- ###Allie Moses
    - Implemented calls to Spotify API
    - Worked with AudioJS JavaScript automation
    - Created scaffolding for portions of app
    - Worked with Bootstrap modals
    - Created frontend features (logo, favicon, 'Meet the Team' layout, wireframes)

- ###Daniel Smith
    - Designed and implemented music player and quiz functionality
    - Created Listen List ('add' functionality, clip player, model updates)
    - Implemented Bootstrap JavaScript features (tabs, menu dropdowns)
    - Implemented calls to iTunes API
    - Set project deadlines and priorities
    - Designed logo and favicon

##Goals
- iTunes Affiliate for profit
- More mobile compatible
- Frosted glass effect on Team page and Leaderboard
- Error handling with major refactoring and testing