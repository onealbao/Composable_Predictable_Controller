% cross product of a set, N times

function X = cartprod(p_set, p_num)
for i = 1:p_num,
    set_size(i) = length(p_set);
    set_copy{i} = p_set;
end
X = zeros(prod(set_size), p_num); %% dim = 1, the product for each row
for i = 1:size(X,1),
    ixVect = ind2subVect(set_size,i);    
    for j = 1:p_num,
        X(i,j) = set_copy{j}(ixVect(j));
    end
end

function v = ind2subVect(siz,ndx)
[out{1:length(siz)}] = ind2sub(siz,ndx);
v = cell2mat(out);