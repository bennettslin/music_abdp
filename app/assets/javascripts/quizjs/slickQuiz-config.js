

var quizJSON = {
    "info": {
        "name":    "",
        "main":    "<p>Music Trivia!</p>",
        "results": "<h5>Play again?</h5><button type='button' class='btn btn-default' action='file:///Users/Mistuh_P/Desktop/SlickQuiz-master/index.html' >Do it! </button>",
        "level1":  "Music Master",
        "level4":  "Music Man/woMan",
        "level5":  "Noob"
    },
    "questions": [
        { // Question 1
            "q": "What's the name of this track?",
            "a": [
                {"option": "<%= p.trackName %>",     "correct": true},
                {"option": "<%= s.trackName %>",     "correct": false},
                {"option": "<%= s1.trackName %>",    "correct": false}

            ],
            "correct": "<p><span>Correct!</span> Nice knowledge. </p>",
            "incorrect": "<p><span>Not Quite.</span> You got the next one!</p>"
        },
        { // Question 2
            "q": "What's the name of the artist?",
            "a": [
                {"option": "<%= p.artistName %>",   "correct": true},
                {"option": "<%= s.artistName %>",   "correct": false},
                {"option": "<%= s1.artistName %>",   "correct": false}

            ],

            "correct": "<p><span>Nice!</span> Kudos to you my friend.</p>",
            "incorrect": "<p><span>Doh!</span> One more shot!</p>"
        },
        {
            "q": "What's the name of the album?",
            "a": [
                {"option": "<%= p.albumName %>",  "correct": true},
                {"option": "<%= s.albumName %>",  "correct": false},
                {"option": "<%= s1.albumName %>",  "correct": false},

            ],
            "correct": "<p><span>Awesome!</span> Go ahead and brush your shoulder off.</p>",
            "incorrect": "<p><span>Aw, that one was tough!</span> Good news is you can always play again.</p>" // no comma here
        }

    ]
};
