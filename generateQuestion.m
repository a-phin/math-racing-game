% i = question number
function q = generateQuestion(i)
% Sample questions for game.
questionBox = ["10 x 5", "144 / 12", "4 x 8", "99 / 11", "3 x 6", "63 / 7", ...
    "1 x 2", "6 / 6", "8 x 9", "132 / 11"];
q = questionBox(i);
end