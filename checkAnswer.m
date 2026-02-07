function isCorrect = checkAnswer(question, userAnswer)
expectedAnswer = ['d', 'b', 'a', 'c', 'b', 'b', 'c', 'a', 'c', 'd'];
isCorrect = (expectedAnswer(question) == userAnswer);
end