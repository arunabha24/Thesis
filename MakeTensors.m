%% -----Make multiple Tensors using the Restaurant and Customer Data---- %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                  %%%%%%%% Input Data Format %%%%%%%%%%
% Number of data sets : 5
% customerData : Has the features for 138 customers with customer index (138x14)
% rating : Has rating for each restaurant from each customer with both customer and restaurant id (1161x5)
% restData : Has the features for 130 restaurants with restaurant id (130x25)

                  %%%%%%%% Output Data Format %%%%%%%%%%
% Tensor Format: 3-way Tensors (I,J,K)
% I = Restaurant features+Customer Features (24+13=37)
% J = Number of Restaurants for each Customer
% K = Number of Customer who rated J Restaurants
% N = Total number of such Tensors

% --------------%%%%%%%%%%%%%%%% Algorithm %%%%%%%%%%%%%%-------------- %

% 1. Identify restaurants for which restaurants features are available (optional, 0 in this case)
% 2. Find customer frequency (also the range of freq, max and min)
% 3. Find frequency of each customer frequency to group them under one tensor
% 4. Create cell array to store each group from step 3 as Tensors
% 5. Initialize the tensors (zero) each with dimension IxJxK
% 6. For each customer, find the all the restaurants he scored
% 7. Assign entire slice to appropriate Tensor at index k = 1,2,...,K
% 8. Follow step 4-7 for group tensor index (stores the UID and CID for each Tensor fiber)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Normalize the data (Optional)
[customerDataN,restDataN] = NormData(customerData,restData);
customerData = customerDataN;
restData = restDataN;

%% Step 1 %%

% noRateCust = FindRestaurant(restData,rating);

%% Step 2 %%

%Number of customers rating multiple restaurants
custFreq = histc(rating(:,1),customerData(:,1));
maxCF = max(custFreq);
minCF = min(custFreq);

%% Step 3 %%

%Unique number of customers rating multiple restaurants
uFreq = unique(custFreq);
%Number of customers rating same number of restaurants
FreqOfFreq = histc(custFreq,uFreq);

%% Step 4,5 %%
groupTensor = cell(numel(uFreq),1);

%Group tensor index to identify which customer and restaurant belongs to which group
groupTIndex = cell(numel(uFreq),1);

%Initialize each tensors
I = size(restData(:,2:end),2)+size(customerData(:,2:end),2);    % rstaurant features+ customer features
gI = 2;
for i=1:numel(uFreq)
    J = uFreq(i);                                               % Number of restaurant scored by ith Customer
    K = FreqOfFreq(i);                                          % Number of customer rating same number of restaurants
    groupTensor{i} = zeros(I,J,K);
    groupTIndex{i} = zeros(gI,J,K);
end

%% Step 6,7 %%

%Track iteration on K
trackIterK = ones(numel(uFreq),1);

%Iterate over rating and create each tensor
for i=customerData(:,1)'
    %Get the appropriate tensor for this customer
    J = custFreq(i);
    tensorIndex = find(uFreq == J);
    tempTensor = groupTensor{tensorIndex};
    
    %Do the same for group tensor index
    tempGI = groupTIndex{tensorIndex};
    
    %Form data vector
    tensorSlice = zeros(I,J);                                   %Initialize each slice
    allRatingIndex = find(rating(:,1)==i);                      %Find all index positions for customer i in the rating table
    
    %Do the same for group tensor index
    gISlice = zeros(gI,J);
    
    %For each customer, find the all the restaurants he scored
    iter1 = 1;
    for j=allRatingIndex'
        %Find the index position in customer and restaurant matrix for
        %feature collection from each
        CID = find(customerData(:,1) == rating(j,1));
        RID = find(restData(:,1) == rating(j,2));
        
        %Make single feature vector using restaurant and customer features
        dataVector = [restData(RID,2:end) customerData(CID,2:end)];
        
        %put it in the designated fiber of the tensor
        tensorSlice(:,iter1) = dataVector';
        
        %update the group tensor index with customer and restaurant id
        gISlice(:,iter1) = [rating(j,1) rating(j,2)]';
        
        iter1 = iter1+1;
    end
    
    %assign entire slice to appropriate Tensor at index k = 1,2,...,K
    k = trackIterK(tensorIndex);
    tempTensor(:,:,k) = tensorSlice;
    groupTensor{tensorIndex} = tempTensor;
    
    %Do the same for group tensor index
    tempGI(:,:,k) = gISlice;
    groupTIndex{tensorIndex} = tempGI;
    
    trackIterK(tensorIndex) = k+1;
end











