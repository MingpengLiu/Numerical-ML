function [net, info] = ANN(layer_neuraons,xTrain,yTrain)

net = feedforwardnet(layer_neuraons);

net.trainFcn = 'trainlm';
net.trainParam.mc = 0.001;
net.trainParam.epochs = 200;
net.trainParam.goal   = 1e-5;
net.trainParam.lr = 0.001;
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;
net.trainparam.max_fail   = 6; 

[net,info] = train(net, xTrain, yTrain);

end



