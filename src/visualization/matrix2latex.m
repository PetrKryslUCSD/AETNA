%   Print a matrix in LaTeX tabular format.
%   matrix2latex(M) prints out the numeric matrix M in a LaTeX tabular
%   format. The '&' character appears between entries in a row, '\\'
%   is appended to the ends of rows.
%
%   Copyright 2008 by Petr Krysl
% 
function s = matrix2latex(M,precision,separator,symbol,Zerotolerance)

    if (~exist('precision','var'))
        precision = 2;
    end
    if (~exist('separator','var'))
        separator = '';
    end
    if (~exist('symbol','var'))
        symbol = [];
    end
    if (~exist('Zerotolerance','var'))
        Zerotolerance = eps;
    end


    if ~isa(M,'double')
        error('Works only for arrays of numbers.')
    elseif ndims(M) > 2
        error('Works only for 2D arrays.')
    end



    % Extend the format specifiers.
    [m,n] = size(M);
    
    S=['\begin{array}{' sprintf('%c',repmat('c',1,n)) '}'   ];

    for i=1:m
        for j=1:n-1
            S=[S  str(M(i,j))  separator ' & ' ];
        end
        S=[S  str(M(i,n))  ' \\' ];
    end

    S=[S '\end{array}' sprintf('\n')];

    % Display or output?
    if nargout==0
        disp(S)
    else
        s = S;
    end
    
    function String =str(Element)
        if (isempty(symbol))
            String =num2str(Element, precision);
        else
            if (abs(Element)>Zerotolerance)
                String =symbol;
            else
                String ='';
            end
        end
    end
end
