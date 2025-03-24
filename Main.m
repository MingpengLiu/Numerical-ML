clear;
rng(2)
%% Load data for tunnel horizontal and vertical displacement
Data_all = load("Data_all.mat");
Data_all = (Data_all.Data_all)';

%% Training set and testing set
X = Data_all(1:7,:);
Y = Data_all(8:end,:);
[x, nor_input] = mapminmax(X, 0, 1);
[y, nor_output] = mapminmax(Y, 0, 1);

train_ratio = 0.8;
a = randperm(length(Data_all));
idx_train = a(1:floor(length(a)*train_ratio));
idx_test = setdiff(a,idx_train);

xTrain = x(:,idx_train); %训练集
xTest = x(:,idx_test); %测试集
yTrain = y(:,idx_train); YTrain = Y(:,idx_train);
yTest = y(:,idx_test); YTest = Y(:,idx_test);

M = size(xTrain, 1);
N = size(yTrain, 1);
%% ANN
layer_neuraons = [20,10]; % [20,10]
[net, info] = ANN(layer_neuraons,xTrain,yTrain);

ysim1_ANN = sim(net, xTrain);ysim2_ANN = sim(net, xTest);
YSim1_ANN = mapminmax("reverse",ysim1_ANN,nor_output);
YSim2_ANN = mapminmax("reverse",ysim2_ANN,nor_output);

%% Random Forest
Trees = 40;
Leaf = 2;
RF_1 = RandomForest(Trees, Leaf, xTrain, yTrain(1,:));
Significance_1 = RF_1.OOBPermutedPredictorDeltaError;
RF_2 = RandomForest(Trees, Leaf, xTrain, yTrain(2,:));
Significance_2 = RF_2.OOBPermutedPredictorDeltaError;
RF_3 = RandomForest(Trees, Leaf, xTrain, yTrain(3,:));
Significance_3 = RF_3.OOBPermutedPredictorDeltaError;
RF_4 = RandomForest(Trees, Leaf, xTrain, yTrain(4,:));
Significance_4 = RF_4.OOBPermutedPredictorDeltaError;

ysim1_RF = [predict(RF_1,xTrain'),predict(RF_2,xTrain'),predict(RF_3,xTrain'),predict(RF_4,xTrain')]';
ysim2_RF = [predict(RF_1,xTest'),predict(RF_2,xTest'),predict(RF_3,xTest'),predict(RF_4,xTest')]';
YSim1_RF = mapminmax("reverse",ysim1_RF,nor_output);
YSim2_RF = mapminmax("reverse",ysim2_RF,nor_output);
%% SVM
ModelSVM_1 = SVM(xTrain, yTrain(1,:));
ModelSVM_2 = SVM(xTrain, yTrain(2,:));
ModelSVM_3 = SVM(xTrain, yTrain(3,:));
ModelSVM_4 = SVM(xTrain, yTrain(4,:));

ysim1_SVM = [predict(ModelSVM_1,xTrain'),predict(ModelSVM_2,xTrain'),predict(ModelSVM_3,xTrain'),predict(ModelSVM_4,xTrain')]';
ysim2_SVM = [predict(ModelSVM_1,xTest'),predict(ModelSVM_2,xTest'),predict(ModelSVM_3,xTest'),predict(ModelSVM_4,xTest')]';
YSim1_SVM = mapminmax("reverse",ysim1_SVM,nor_output);
YSim2_SVM = mapminmax("reverse",ysim2_SVM,nor_output);