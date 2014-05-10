function noRateCust = FindRestaurant(restData,rating)

% 'FINDRESTAURANT' Summary of this function goes here
%  Detailed explanation goes here

%find the unique restaurants in rating data
uRestRate = unique(rating(:,2));

%set that collects all the customer ID index for which no ratings are available
noRateCust = zeros(1);

c = 1;

%find if not present
for i=1:numel(uRestRate)
    flag = true;
    for j=1:size(restData,1)
        if(uRestRate(i) == restData(j,1))
            flag = false;
            break;
        end
    end
    if(flag)
        noRateCust(c) = i;
        c = c+1;
    end
end



end