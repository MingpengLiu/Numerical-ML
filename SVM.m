function ModelSVM = SVM(xTrain, yTrain)

ModelSVM = fitrsvm(xTrain', yTrain', ...
    'KernelFunction','gaussian', ...
    'KernelScale','auto', ...
    "Alpha",0.01*ones(size(xTrain',1),1));
end










