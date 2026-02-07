% Clear command window, variables from workspace, and any figure windows open.
clc
clear
close all

% Elementary Multiplication and Division Racing Game

% Initialize simpleGameEngine object with racing pixel sprite sheet
race_scene = simpleGameEngine('racingpixelsprites.png', 16, 16, 10, [135, 206, 235]);

% while 1 allows infinite replayability on the game until the user presses a key to end. 
while 1
    % Initialize variables to indices in sprite sheets for sprites in 2 or
    % more scenes
    emptySprite = 23; % Blank sprite to scale dimensions of game screen
    blueSky = 9;
    grass = 10;
    clouds = 21;
    playButton = 12;
    soundOnButton = 14;
    soundOffButton = 15;

    % Initialize main menu specific sprites to the indices in sprite sheet
    RedCarSide = 5;
    GreenCarSide = 6;
    BlueCarSide = 7;
    PurpleCarSide = 8;

    % Create a main display for the dimensions of the game screen, to be
    % modified for each scene
    mainDisplay = emptySprite * ones(10, 20);

    % Create main menu background with blue sky and gress grass
    mainDisplay(1:7,:) = blueSky;
    mainDisplay(8:end,:) = grass;
    
    % Add sprites to layer over main menu background
    mainMenuSpriteDisplay = emptySprite * ones(10, 20);
    mainMenuSpriteDisplay(5, 11) = playButton;
    mainMenuSpriteDisplay(1, 20) = soundOnButton;
    mainMenuSpriteDisplay(8, 3) = RedCarSide;
    mainMenuSpriteDisplay(8, 8) = GreenCarSide;
    mainMenuSpriteDisplay(8, 13) = BlueCarSide;
    mainMenuSpriteDisplay(8, 18) = PurpleCarSide;
    mainMenuSpriteDisplay(2:4:6, 2:2:18) = clouds;
    mainMenuSpriteDisplay(4, 3:2:19) = clouds;

    % Create main menu scene
    drawScene(race_scene, mainDisplay, mainMenuSpriteDisplay);
    % Title above game display
    title('Elementary Multiplication/Division Racing Demo');
    % Text in game display, right below text
    mainMenuText = text(1200, 100, 'Press the play button to begin!', 'FontSize', 20);
    % Mouse input for play button toggle
    [rM, cM, bM] = getMouseInput(race_scene);

    if bM == 1 && rM == 5 && cM == 11
        % Delete main menu text
        delete(mainMenuText);
        % Initialize gameplay sprites to the indices in sprite sheet
        RedCarSprite = 1;
        GreenCarSprite = 2;
        BlueCarSprite = 3;
        PurpleCarSprite = 4;
        road = 11;
        pauseButton = 13;
        correctCheck = 19;
        incorrectX = 20;

        % Modify main display sprites
        mainDisplay(3:end,1:7) = grass;
        mainDisplay(3:end,14:20) = grass;
        mainDisplay(:, 8:13) = road;

        % Add sprites to layer over main display background
        racingSpriteDisplay = emptySprite * ones(10, 20);
        racingSpriteDisplay(1, 19) = pauseButton;
        racingSpriteDisplay(1, 20) = soundOnButton;
        racingSpriteDisplay(7, 9) = RedCarSprite;
        racingSpriteDisplay(7, 10) = GreenCarSprite;
        racingSpriteDisplay(7, 11) = BlueCarSprite;
        racingSpriteDisplay(7, 12) = PurpleCarSprite;
        racingSpriteDisplay(2, 2:4:6) = clouds;
        racingSpriteDisplay(2, 15:4:20) = clouds;
        racingSpriteDisplay(1, 4:13:17) = clouds;

        % Create gameplay scene
        drawScene(race_scene, mainDisplay, racingSpriteDisplay);

        % Assign user to red car and a user score variable for the car.
        userScore = 0;

        % Assign question number for loop
        questionNum = 1;

        % Loop iterates on 10 generated sample multiplication/division 
        % questions and while current user score is less than 8. If user
        % score is 8 or higher, stops gameplay
        while questionNum <= 10 && userScore < 8
            question = generateQuestion(questionNum);
            % Show question above game display
            title(question);
            [letterA, letterB, letterC, letterD] = generateChoices(questionNum);
            letterChoices = "A )    " + letterA + "    B )    " + letterB + ...
                "    C )    " + letterC + "    D )     " + letterD;
            answers = text(10, 20, letterChoices, "FontSize",20);
            % Retrieve user input
            letter = getKeyboardInput(race_scene);
            % Evaluates only if keyboard input is one of the first four
            % alphabetical letters
            % Checks if the user-inputted letter (char) is equivalent to
            % the expected letter (char). If correct, adds a point to the
            % user's score and displays a checkmark to the top right next
            % to the road. Else, displays an X to the top right next to the
            % road.
            if letter == 'a' || letter == 'b' || letter == 'c' || letter == 'd'
                isCorrect = checkAnswer(questionNum, letter);
                if isCorrect
                    userScore = userScore + 1;
                    racingSpriteDisplay(1, 14) = correctCheck;
                    drawScene(race_scene, mainDisplay, racingSpriteDisplay);
                else
                    racingSpriteDisplay(1, 14) = incorrectX;
                    drawScene(race_scene, mainDisplay, racingSpriteDisplay);
                end
            end
            % Before the next question, delete the text answers displayed for
            % the previous question
            delete(answers);
            % Increase question number before body iterates again
            questionNum = questionNum + 1;
        end

        % Initialize result sprites to the indices in sprite sheet
        bronzeTrophy = 16;
        silverTrophy = 17;
        goldTrophy = 18;
        replay = 22;

        % Modify mainDisplay layer
        mainDisplay(1:7,:) = blueSky;
        mainDisplay(8:end,:) = grass;

        % Create resultSpriteDisplay to layer on top of main display, and
        % add according sprites
        resultSpriteDisplay = emptySprite * ones(10, 20);
        resultSpriteDisplay(2, 6) = clouds;
        resultSpriteDisplay(2:4:6, 2:2:18) = clouds;
        resultSpriteDisplay(4, 3:2:19) = clouds;
        resultSpriteDisplay(2, 2) = goldTrophy; % First place sprite
        resultSpriteDisplay(4, 2) = silverTrophy; % Second place sprite
        resultSpriteDisplay(6, 2) = bronzeTrophy; % Third place sprite
        resultSpriteDisplay(2, 4) = RedCarSide; % First place car
        resultSpriteDisplay(4, 4) = GreenCarSide; % Second place car
        resultSpriteDisplay(6, 4) = BlueCarSide; % Third place car
        resultSpriteDisplay(5, 11) = replay;
        resultSpriteDisplay(1, 20) = soundOnButton;

        % Create result screen
        drawScene(race_scene, mainDisplay, resultSpriteDisplay);
        title('Results');
        resultText = text(1000, 100, 'Thanks for playing! Press q to quit or any other key to replay game', 'FontSize', 20);
    end
    % Retrieves any key the user provides
    key = getKeyboardInput(race_scene);
    % If the keyboard input equals q, breaks out of the if and infinite
    % gameplay loop, ending game. Any other keyboard input will return to
    % the main menu
    if key == 'q'
        break;
    end
    % Remove text from the result screen before quitting/going back to main
    % menu
    delete(resultText);
end