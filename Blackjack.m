%% Blackjack

clc
clear

% Initialize the simpleGameEngine for Blackjack
sSize = 16; % sprite size in pixels
zFactor = 4; % zoom factor to enlarge sprites
BGC = [34, 139, 34]; % green background color for table
card_scene = simpleGameEngine('retro_cards.png', sSize, sSize, zFactor, BGC);
splash_scene = simpleGameEngine('splash_screen.png', 33, 33, 5);

%% Splash Screen
% Display splash screen and wait for user input to start the game
drawScene(splash_scene, [1,12,13,14,1;1,1,11,1,1]);
title('Welcome to Blackjack!');
xlabel('Click to start the game.');

% Wait for user input to continue
[r, c] = getMouseInput(splash_scene);
if r == 2 && c == 3 % if player clicks on start, loop ends
    close;
end

% Defining locations of each card in the image retro_cards.png

% Hearts
hearts_A = 21;
hearts_two = 22;
hearts_three = 23;
hearts_four = 24;
hearts_five = 25;
hearts_six = 26;
hearts_seven = 27;
hearts_eight = 28;
hearts_nine = 29;
hearts_ten = 30;
hearts_jack = 31;
hearts_queen = 32;
hearts_king = 33;

% Diamonds
diamonds_A = 34;
diamonds_two = 35;
diamonds_three = 36;
diamonds_four = 37;
diamonds_five = 38;
diamonds_six = 39;
diamonds_seven = 40;
diamonds_eight = 41;
diamonds_nine = 42;
diamonds_ten = 43;
diamonds_jack = 44;
diamonds_queen = 45;
diamonds_king = 46;

% Clubs
clubs_A = 47;
clubs_two = 48;
clubs_three = 49;
clubs_four = 50;
clubs_five = 51;
clubs_six = 52;
clubs_seven = 53;
clubs_eight = 54;
clubs_nine = 55;
clubs_ten = 56;
clubs_jack = 57;
clubs_queen = 58;
clubs_king = 59;

% Spades
spades_A = 60;
spades_two = 61;
spades_three = 62;
spades_four = 63;
spades_five = 64;
spades_six = 65;
spades_seven = 66;
spades_eight = 67;
spades_nine = 68;
spades_ten = 69;
spades_jack = 70;
spades_queen = 71;
spades_king = 72;

% Assigning names to all the cards

cardNames = {'Ace of Hearts', '2 of Hearts', '3 of Hearts', '4 of Hearts', '5 of Hearts', '6 of Hearts', '7 of Hearts', '8 of Hearts', '9 of Hearts', '10 of Hearts', 'Jack of Hearts', 'Queen of Hearts', 'King of Hearts', ...
             'Ace of Diamonds', '2 of Diamonds', '3 of Diamonds', '4 of Diamonds', '5 of Diamonds', '6 of Diamonds', '7 of Diamonds', '8 of Diamonds', '9 of Diamonds', '10 of Diamonds', 'Jack of Diamonds', 'Queen of Diamonds', 'King of Diamonds', ...
             'Ace of Clubs', '2 of Clubs', '3 of Clubs', '4 of Clubs', '5 of Clubs', '6 of Clubs', '7 of Clubs', '8 of Clubs', '9 of Clubs', '10 of Clubs', 'Jack of Clubs', 'Queen of Clubs', 'King of Clubs', ...
             'Ace of Spades', '2 of Spades', '3 of Spades', '4 of Spades', '5 of Spades', '6 of Spades', '7 of Spades', '8 of Spades', '9 of Spades', '10 of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades'};

% Function to calculate the value of a hand
calculateScore = @(hand) sum(min(10, mod(hand - 21, 13) + 1));

% Draw two random cards for player and dealer
allCards = [hearts_A:hearts_king, diamonds_A:diamonds_king, clubs_A:clubs_king, spades_A:spades_king]; % Create an array of all cards
randomIndices = randperm(length(allCards), 4); % Randomly select 4 cards

playerHand = allCards(randomIndices(1:2)); % Player's initial hand
dealerHand = allCards(randomIndices(3:4)); % Dealer's initial hand

% Calculate initial scores
playerScore = calculateScore(playerHand);
dealerScore = calculateScore(dealerHand);

% Button for Hit action (position: bottom right of the scene)
hitButtonPos = [5, 5]; % Position of the hit button in the scene matrix
hitButtonIndex = 9; % Using a distinct card sprite for visibility
stayButtonPos = [5, 4]; % Position of the stay button in the scene matrix
stayButtonIndex = 10; % Using a distinct card sprite for visibility

% Create a matrix for the scene
background_sprite = 1; 
sceneMatrix = background_sprite * ones(5, 5); % Initialize with the background sprite
sceneMatrix(1, 1:2) = playerHand; % Player's cards in the first row
sceneMatrix(3, 1:2) = dealerHand; % Dealer's cards in the third row
sceneMatrix(hitButtonPos(1), hitButtonPos(2)) = hitButtonIndex; % Place the hit button
sceneMatrix(stayButtonPos(1), stayButtonPos(2)) = stayButtonIndex; % Place the stay button

%% Display the initial scene
drawScene(card_scene, sceneMatrix);
title('Blackjack: Player vs Dealer');
xlabel(['Player: ', strjoin(cellfun(@(x) cardNames{x - 20}, num2cell(playerHand), 'UniformOutput', false), ', '), ...
    ' | Dealer: ', strjoin(cellfun(@(x) cardNames{x - 20}, num2cell(dealerHand), 'UniformOutput', false), ', '), ...
    ' | Player Score: ', num2str(playerScore), ' | Dealer Score: ', num2str(dealerScore)]);

playerTurn = true;
playerStays = false;
dealerStays = false;

while ~playerStays || ~dealerStays
    if playerTurn && ~playerStays
        %% Player's turn
        disp('Player''s turn: Click on the "Hit" button to draw a new card or "Stay".');
        [x, y] = getMouseInput(card_scene);

        if x == hitButtonPos(2) && y == hitButtonPos(1)
            % Player clicked "Hit" button
            % Draw a random card for the player
            remainingCards = setdiff(allCards, [playerHand, dealerHand]);
            newCard = remainingCards(randi(length(remainingCards)));
            playerHand = [playerHand, newCard];

            % Update player score and scene
            playerScore = calculateScore(playerHand);
            sceneMatrix = background_sprite * ones(5, 5);
            sceneMatrix(1, 1:length(playerHand)) = playerHand;
            sceneMatrix(3, 1:length(dealerHand)) = dealerHand;
            sceneMatrix(hitButtonPos(1), hitButtonPos(2)) = hitButtonIndex;
            sceneMatrix(stayButtonPos(1), stayButtonPos(2)) = stayButtonIndex; % Keep the stay button visible
            drawScene(card_scene, sceneMatrix);

            % Update title and status
            title('Blackjack: Player Hit');
            xlabel(['Player: ', strjoin(cellfun(@(x) cardNames{x - 20}, num2cell(playerHand), 'UniformOutput', false), ', '), ...
                ' | Dealer: ', strjoin(cellfun(@(x) cardNames{x - 20}, num2cell(dealerHand), 'UniformOutput', false), ', '), ...
                ' | Player Score: ', num2str(playerScore), ' | Dealer Score: ', num2str(dealerScore)]);

            % If player score goes over 21, Dealer automatically wins and
            % Dealer wins! screen is displayed
            if playerScore > 21
                winner = 'Dealer wins!';
                drawScene(splash_scene, [1,12,13,14,1;1,1,10,1,1]);
                disp(['Game Over: ', winner]);
                title(['Game Over: ', winner]);
                pause(1);
                return;
            end

            % If player score equals 21, player automatically wins and
            % Player wins! screen is displayed
            if playerScore == 21
                winner = 'Player wins!';
                drawScene(splash_scene, [1,12,13,14,1;1,1,9,1,1]);
                disp(['Game Over: ', winner]);
                title(['Game Over: ', winner]);
                pause(1);
                return;
            end
        elseif x == stayButtonPos(2) && y == stayButtonPos(1)
            % Player clicked "Stay" button
            playerStays = true;
        end
    end
    
    %% Dealer's turn
    if ~dealerStays
        if dealerScore < 17 % Simple strategy for dealer to hit if score is less than 17
            % Draw a random card for the dealer
            remainingCards = setdiff(allCards, [playerHand, dealerHand]); % Exclude already drawn cards
            newCard = remainingCards(randi(length(remainingCards))); % Randomly select a card
            dealerHand = [dealerHand, newCard]; % Add new card to dealer's hand
            cardName = cardNames{find(allCards == newCard)}; % Get the name of the drawn card

            % Update dealer score
            dealerScore = calculateScore(dealerHand);

            % Update the scene matrix
            sceneMatrix = background_sprite * ones(5, 5); % Reinitialize with background sprite
            sceneMatrix(1, 1:length(playerHand)) = playerHand; % Update player's hand in the first row
            sceneMatrix(3, 1:length(dealerHand)) = dealerHand; % Update dealer's hand in the third row
            sceneMatrix(hitButtonPos(1), hitButtonPos(2)) = hitButtonIndex; % Keep the hit button
            sceneMatrix(stayButtonPos(1), stayButtonPos(2)) = stayButtonIndex; % Keep the stay button visible

            % Display updated scene
            drawScene(card_scene, sceneMatrix);

            % Update title and status
            title('Blackjack: Dealer Hits');
            xlabel(['Player: ', strjoin(cellfun(@(x) cardNames{x - 20}, num2cell(playerHand), 'UniformOutput', false), ', '), ...
                ' | Dealer: ', strjoin(cellfun(@(x) cardNames{x - 20}, num2cell(dealerHand), 'UniformOutput', false), ', '), ...
                ' | Player Score: ', num2str(playerScore), ' | Dealer Score: ', num2str(dealerScore)]);

            %% Check for the game outcome
            if dealerScore >= 17
                % Dealer stays
                dealerStays = true;
                disp('Dealer stays.');
    
                % Determine the winner
                if playerScore > 21
                    % Player busts
                    winner = 'Dealer wins!';
                    output = 10;
                elseif dealerScore > 21
                    % Dealer busts
                    winner = 'Player wins!';
                    output = 9;
                elseif playerScore > dealerScore
                    % Player wins
                    winner = 'Player wins!';
                    output = 9;
                elseif playerScore < dealerScore
                    % Dealer wins
                    winner = 'Dealer wins!';
                    output = 10;
                else
                    % Tie
                    winner = 'It''s a tie!';
                    output = 1;
                end

                %% Display winner
                % Draw winning screen which shows which player won
                drawScene(splash_scene, [1,12,13,14,1;1,1,output,1,1]);
                disp(['Game Over: ', winner]);
                title(['Game Over: ', winner]);
                
                pause(1);
                break;
            end
        end
    end
end