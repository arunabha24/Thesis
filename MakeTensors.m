%% -----Make multiple Tensors using the Restaurant and Customer Data---- %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



                 %%%%%%%% Input Data Format %%%%%%%%%%

% Number of data sets : 5

% UIDCustData : Has customer index for customerData (1-138)

% UIDRating : Has customer index from the rating data set (1161)

% customerData : Has the features for 138 customers (138x13)

% rating : Has rating for each restaurant from each customer (1161x4)

% restData : Has the features for 130 restaurants



                 %%%%%%%% Output Data Format %%%%%%%%%%

% Tensor Format: 3-way Tensors (I,J,K)

% I = Restaurant features+Customer Features

% J = Number of Restaurants for each Customer

% K = Number of Customer who rated J Restaurants

% N = Total number of such Tensors



% --------------%%%%%%%%%%%%%%%% Algorithm %%%%%%%%%%%%%%-------------- %

% 1. Identify restaurants for which restaurants features are available

% 2. 





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Step 1



tempRestData = FindRestaurant(restData,rating);
