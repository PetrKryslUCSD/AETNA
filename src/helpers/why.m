function why(n)
%WHY    Provides succinct answers to almost any question.
%   WHY, by itself, provides a random answer.
%   WHY(N) provides the N-th answer.
%   Please embellish or modify this function to suit your own tastes.

%   Copyright 1984-2014 The MathWorks, Inc.
%   Modified by Petr Krysl, 2016. 

a = special_case;

a(1) = upper(a(1));
disp(a);


% ------------------

function a = special_case
k=tic; while k>18, k=k/2; end
switch randi(k)
    case 1
        a = 'why not?';
    case 2
        a = 'don''t ask!';
    case 3
        a = 'it''s your karma.';
    case 4
        a = 'stupid question!';
    case 5
        a = 'how should I know?';
    case 6
        a = 'can you rephrase that?';
    case 7
        a = 'it should be obvious. If it isn''t, find something else to do please.';
    case 8
        a = 'It''s not my fault, the devil made me do it.';
    case 9
        a = 'I don''t know, the computer did it.';
    case 10
        a = 'Let me think about it...';
    case 11
        a = 'Never mind.';
    case 12
        a = 'don''t you have something better to do?';
    case 13
        a = 'Sorry, I''m busy.';
    case 14
        a = 'Why do you ask?';
    case 15
        a = 'Why does anyone do anything?';
    case 16
        a = 'I know you will be disappointed, but I have no clue!';
    case 17
        a = 'Are you sure you want to know?';
    otherwise
        a = '???';
end
