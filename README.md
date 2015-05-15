#Aptitune

  - [Aptitune GitHub repo](https://github.com/bennettslin/music_abdp)
  - [Aptitune on Heroku](http://aptitune.herokuapp.com)

Aptitune is a simple app that broadens your horizons and tests your knowledge of musical artists by playing sample clips and posing three trivia questions per track. You can focus your musical exploration by selecting your preferred genres, and you can even add tracks you love to your Listen List.

###How To Play

1. Click Start Quiz to test your knowledge of any music genre. Or else log in and choose your genre preferences in Dashboard  Genres / Profile.

2. For each track, you will be asked to name the artist, album, and track title.

3. After each quiz, you can save the song to your favorites, stored in Dashboard Listen List. Or just skip to the next one.

   Check the Leaderboards to compare yourself to the top-ranked players. Or login through Facebook and compare yourself to your friends in Dashboard  Friends.

  For each correct answer, you gain three trophies. But be careful—for each incorrect guess, you also lose one!

##Developers

Aptitune was developed by Patrick Eldridge, Bennett Lin, Allie Moses, and Daniel Smith, students of General Assembly's Web Development Immersive.

##Version

1.0.0

##Tech

Aptitune was built with Ruby, Ruby on Rails, HTML5, CSS3, iTunes API, D3, PostgreSQL, jQuery, JavaScript, iCheck plug-in, Facebook OAuth, Bcrypt.

##Challenges

The biggest challenge was coming up with an idea; our group wanted to create an app about which we felt passionately. Eventually, Aptitune came to fruition. We are all very pleased with the concept and outcome and feel proudly to show this creation in our portfolios.

Some other challenges were ensuring that the finalized Heroku version worked correctly, switching from the Spotify API to iTunes during the final stage of our project, and deciding on some of the more minute design decisions.

##Contributions

- ###Patrick Eldridge
    - Worked with Spotify API to narrow by genre and artist
    - Implemented artist/genre arrays to allow player to controller to pull search data
    - Implemented iCheck plug-in
    - Added 'Delete' AJAX method to Listen List
    - Contributed to database models and associations between User, Genre, and Song

- ###Bennett Lin
    - Created primary app scaffolding and database models
    - Implemented encryption and OAuth
    - Implemented and massaged Leaderboard data into D3
    - Served as Git Master, efficiently and promptly managed repo
    - Managed Heroku deployment
    -

- ###Allie Moses
    - Implemented the Spotify API
    - Worked with AudioJS JavaScript automation
    - Created scaffolding for portions of app
    - Worked with Bootstrap modals
    - Worked with front-end decisions (logo, favicon, 'Meet the Team' layout, wireframes)

- ###Daniel Smith
    - Designed and implemented the music player and quiz functionality
    - Created Listen List ('add' functionality, clip player, model updates)
    - Implemented Bootstrap JavaScript features (tabs, menu dropdowns)
    - Implemented iTunes API
    - Set project deadlines and priorities
    - Designed logo and favicon

##Goals
- iTunes Affliate for profit
- More mobile compatable
- Add slogan "Gives Good Ear"
- Frosted glass effect on Team page and Leaderboard
