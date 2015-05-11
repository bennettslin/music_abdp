

var quizJSON = {
    "info": {
        "name":    "name",
        "main":    "<p>main</p>",
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
            "correct": "<p><span>Correct!</p>",
            "incorrect": "<p>Incorrect</p>"
        },
        { // Question 2
            "q": "What's the name of the artist?",
            "a": [
            {"option": '<%= @song2_artist %>',   "correct": true},
            {"option": "<%= s.artistName %>",   "correct": false},
            {"option": "<%= s1.artistName %>",   "correct": false}

            ],

            "correct": "<p>Correct!</p>",
            "incorrect": "<p>Incorrect!</p>"
        },
        {
            "q": "What's the name of the album?",
            "a": [
            {"option": "<%= p.albumName %>",  "correct": true},
            {"option": "<%= s.albumName %>",  "correct": false},
            {"option": "<%= s1.albumName %>",  "correct": false},

            ],
            "correct": "<p>Correct!</p>",
            "incorrect": "<p>Incorrect!</p>" // no comma here
        }

        ]
    };
