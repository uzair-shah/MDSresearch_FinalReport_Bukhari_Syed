function BoltzmanM = BoltzmanFunc(X,t)
    kb = 1; %Boltzman constant %Dummy constant since I am not using energies
    T = t; %25C in Kelvin
    
    M1 = zeros(size(X)); %Exponentiating values in matrix
    [rows, cols] = size(X);
    for i = 1:rows
        for j = 1:cols
            value = X(i,j); 
            if value >= 0
                M1(i,j) = exp(-value/(kb*T));
            else
                M1(i,j) = 0;
            end
        end
    end
    
    M2 = M1;
    S2 = sum(M2,2); %column vector returning sum of each row
    BoltzmanM = zeros(size(M1));
    [numRows, numCols] = size(M2); % Determine dimensions of M2
    for i = 1:numRows
        for j = 1:numCols
            BoltzmanM(i, j) = M2(i, j) / S2(i); % Calculate Boltzmann probabilities
        end
    end
    
end